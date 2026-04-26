#!/bin/bash
# Ferramenta de Busca de Conhecimento SDO (RAG-Enabled)
# Uso: bash scripts/tools/search-knowledge.sh "termo_ou_pergunta"

QUERY=$1

if [ -z "$QUERY" ]; then
  echo "❌ Uso: bash scripts/tools/search-knowledge.sh <pergunta_ou_termo>"
  exit 1
fi

echo "🔍 Iniciando Busca de Conhecimento Robusta para '$QUERY'..."
echo "--------------------------------------------------------------"

# 🧠 1. Busca Robusta (RAG via Obsidian MCP)
echo "🧠 [VETORIAL / BRAIN (MCP)]"
echo "INFO: O Orquestrador DEVE agora chamar as ferramentas 'mcp_ObsidianBrain_search_notes' e 'mcp_ObsidianBrain_read_note'."
echo "DICA: Use 'search_notes' para encontrar referências e 'read_note' para detalhes de ADRs e lições aprendidas."
echo "--------------------------------------------------------------"

# 📚 2. Busca Rápida em Lições Aprendidas (Fallback)
echo "📚 [FALLBACK: LESSONS_LEARNED.md]"
if [ -f "docs/LESSONS_LEARNED.md" ]; then
  grep -i -C 3 "$QUERY" docs/LESSONS_LEARNED.md || echo "Nenhuma lição encontrada para '$QUERY'."
else
  echo "Arquivo não existe."
fi
echo "--------------------------------------------------------------"

# ⚙️ 3. Busca em Regras de Sistema
echo "⚙️ [SYSTEM_SPECIFICATION.md]"
if [ -f "docs/product/SYSTEM_SPECIFICATION.md" ]; then
  grep -i -C 3 "$QUERY" docs/product/SYSTEM_SPECIFICATION.md || echo "Nenhuma regra encontrada para '$QUERY'."
else
  echo "Arquivo não existe."
fi
echo "--------------------------------------------------------------"

# 🏛️ 4. Busca em Arquitetura
echo "🏛️ [ARCHITECTURE.md]"
if [ -f "docs/product/ARCHITECTURE.md" ]; then
  grep -i -C 3 "$QUERY" docs/product/ARCHITECTURE.md || echo "Nenhuma diretriz arquitetural encontrada para '$QUERY'."
else
  echo "Arquivo não existe."
fi
echo "--------------------------------------------------------------"

echo "✅ Fim da busca. Combine os resultados do grep com a saída da ferramenta 'search_memory' para máxima precisão."
