#!/bin/bash
# Hook Nativo: Pre-Spec Validation
# Executado automaticamente pelo Gemini CLI ANTES de o agente responder ao usuário.
# Objetivo: Garantir que o projeto foi "bootstrapped" antes de qualquer tarefa.

# Logs visuais para o usuário (stderr)
echo "[INFO] Verificando integridade da configuração do projeto..." >&2

PROJECT_CONFIG="${GEMINI_PROJECT_DIR:-.}/docs/product/PROJECT_CONFIG.md"

if [ ! -f "$PROJECT_CONFIG" ]; then
    echo "[ERROR] PROJECT_CONFIG.md não encontrado." >&2
    
    cat <<EOF
{
  "status": "rejected",
  "reason": "O arquivo docs/product/PROJECT_CONFIG.md não existe. Você deve iniciar a Fase 0 (Bootstrap) ou rodar o comando /analyze-project antes de prosseguir com qualquer desenvolvimento."
}
EOF
    exit 2
fi

# Verifica se os placeholders [Ex: ...] ainda existem
if grep -q "\[Ex:" "$PROJECT_CONFIG"; then
    echo "[ERROR] PROJECT_CONFIG.md contém placeholders (ex: [Ex: Java])." >&2
    
    cat <<EOF
{
  "status": "rejected",
  "reason": "O arquivo docs/product/PROJECT_CONFIG.md não foi preenchido. Você deve preencher a stack tecnológica real (removendo os placeholders '[Ex: ...]') antes de iniciar a Fase 1."
}
EOF
    exit 2
fi

# Se passou, permite o agente continuar normalmente
echo "[SUCCESS] Configuração validada." >&2
cat <<EOF
{
  "status": "approved",
  "message": "Configurações do projeto estão íntegras."
}
EOF
exit 0
