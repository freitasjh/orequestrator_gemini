#!/bin/bash
# scripts/tools/compact-brain.sh
# Finalidade: Coleta conhecimento técnico do projeto e compacta via gemini-flash para reduzir tokens.

TOPIC=$1
[ -z "$TOPIC" ] && TOPIC="Desenvolvimento Geral"

# 1. Coletar arquivos fonte de verdade
FILES=(
  "docs/product/ARCHITECTURE.md"
  "docs/product/SYSTEM_SPECIFICATION.md"
  "docs/product/PROJECT_CONFIG.md"
  "docs/LESSONS_LEARNED.md"
)

RAW_CONTEXT=""
for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    RAW_CONTEXT+="\n--- FILE: $file ---\n"
    RAW_CONTEXT+=$(cat "$file")
  fi
done

# 2. Instrução de compactação para o Flash
PROMPT="Aja como um minificador de conhecimento para LLMs. 
Seu objetivo é extrair apenas as regras técnicas, restrições arquiteturais e padrões de código essenciais para o tópico: '$TOPIC'.
- Remova exemplos longos, textos introdutórios e formatação visual desnecessária.
- Mantenha bullet points densos e semânticos.
- O resultado deve ser otimizado para que outra IA (como o Gemini Pro) entenda perfeitamente as diretrizes sem gastar muitos tokens.
- Se houver lições aprendidas relevantes para o tópico, inclua-as de forma ultra-abreviada.

TEXTO ORIGINAL:
$RAW_CONTEXT"

# 3. Chamar o Gemini Flash (silenciosamente)
# Nota: Redirecionamos stderr para /dev/null para evitar poluição visual se o modelo não estiver disponível ou houver avisos.
echo "🧠 Compactando conhecimento do Cérebro para: $TOPIC..." >&2

# Tenta usar o gemini ask se disponível no path
if command -v gemini >/dev/null 2>&1; then
  # Usamos o flash-1.5 ou 2.0 dependendo da disponibilidade para economia
  COMPACTED=$(echo "$PROMPT" | gemini ask --silent --model gemini-1.5-flash 2>/dev/null)
  
  if [ -n "$COMPACTED" ]; then
    echo "--- CONTEXTO COMPACTADO (SSoT) ---"
    echo "$COMPACTED"
    echo "----------------------------------"
  else
    echo "⚠️ Falha na compactação. Usando contexto bruto (fallback)." >&2
    echo "$RAW_CONTEXT" | head -n 100 # Fallback limitado para não explodir tokens
  fi
else
  echo "⚠️ CLI 'gemini' não encontrado. Usando busca local simplificada." >&2
  grep -h -i -A 5 "$TOPIC" "${FILES[@]}" 2>/dev/null
fi
