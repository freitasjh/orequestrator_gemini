#!/bin/bash
# change-phase.sh - Utilitário para o Orquestrador atualizar a Máquina de Estados (FSM)

PHASE=$1
ISSUE=$2

if [ -z "$PHASE" ]; then
  echo "Uso: bash scripts/change-phase.sh <numero_da_fase> [nome_da_issue_ativa]"
  exit 1
fi

STATE_DIR=".gemini"
STATE_FILE="$STATE_DIR/STATE.json"

mkdir -p "$STATE_DIR"

cat <<EOF > "$STATE_FILE"
{
  "current_phase": $PHASE,
  "active_issue": "$ISSUE",
  "updated_at": "$(date -Iseconds)"
}
EOF

echo "✅ Estado do projeto atualizado com sucesso para Fase $PHASE."
