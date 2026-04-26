#!/bin/bash
# maestro-prompt.sh - Carrega as instruções da fase atual baseada no STATE.json

STATE_FILE=".gemini/STATE.json"
PHASES_DIR="docs/process/phases"

if [ ! -f "$STATE_FILE" ]; then
  echo "⚠️ Erro: Arquivo de estado $STATE_FILE não encontrado."
  exit 1
fi

# Extrair current_phase do JSON usando grep/sed (para evitar dependência de jq)
PHASE=$(grep '"current_phase":' "$STATE_FILE" | sed -E 's/.*"current_phase":[[:space:]]*([0-9]+).*/\1/')

if [ -z "$PHASE" ]; then
  echo "⚠️ Erro: Não foi possível identificar a fase atual em $STATE_FILE."
  exit 1
fi

PHASE_FILE="$PHASES_DIR/phase-$PHASE.md"

if [ ! -f "$PHASE_FILE" ]; then
  echo "⚠️ Erro: Instruções para a Fase $PHASE não encontradas em $PHASE_FILE."
  exit 1
fi

echo "---"
echo "PROJETO EM EXECUÇÃO: $(grep '"active_issue":' "$STATE_FILE" | sed -E 's/.*"active_issue":[[:space:]]*"([^"]+)".*/\1/')"
echo "FASE ATUAL: $PHASE"
echo "---"
echo ""
cat "$PHASE_FILE"
echo ""
echo "---"
echo "⚠️ IMPORTANTE: Siga apenas as instruções da Fase $PHASE. Não pule etapas."
