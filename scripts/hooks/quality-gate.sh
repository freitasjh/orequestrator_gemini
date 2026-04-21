#!/bin/bash
# Hook Nativo: Quality Gate Check
# Executado após certas ferramentas de finalização ou comandos customizados
# Objetivo: Impedir que uma task seja concluída se houver reprovação no Board.

echo "[INFO] Iniciando validação rigorosa de Quality Gate..." >&2

BOARD="${GEMINI_PROJECT_DIR:-.}/docs/backlog/BOARD.md"

if [ ! -f "$BOARD" ]; then
    echo "[ERROR] BOARD.md não encontrado." >&2
    cat <<EOF
{
  "status": "rejected",
  "reason": "O arquivo docs/backlog/BOARD.md não existe. Não é possível rodar o Quality Gate."
}
EOF
    exit 2
fi

# Verifica se existe algum veredito de REJECTED ou CHANGES REQUESTED ativo
if grep -qE "REJECTED|CHANGES REQUESTED" "$BOARD"; then
    echo "[ERROR] Quality Gate Falhou: Tarefas reprovadas encontradas." >&2
    cat <<EOF
{
  "status": "rejected",
  "reason": "O Quality Gate falhou. Existem issues marcadas como REJECTED ou CHANGES REQUESTED no BOARD.md. Você deve corrigir essas pendências e garantir que o status no board seja atualizado para APPROVED antes de tentar finalizar (Fase 6/7)."
}
EOF
    exit 2
fi

echo "[SUCCESS] Quality Gate Aprovado." >&2
cat <<EOF
{
  "status": "approved",
  "message": "Quality Gate superado. Nenhuma pendência crítica encontrada no Board."
}
EOF
exit 0
