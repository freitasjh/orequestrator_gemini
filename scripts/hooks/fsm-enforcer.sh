#!/bin/bash
# Hook Nativo: FSM Enforcer (Máquina de Estados Finita)
# Impede que o agente pule fases ou realize ações destrutivas fora de hora.

echo "[INFO] Verificando permissões da Máquina de Estados (FSM)..." >&2

STATE_FILE="${GEMINI_PROJECT_DIR:-.}/.gemini/STATE.json"

if [ ! -f "$STATE_FILE" ]; then
    PHASE=0
else
    # Extrai o número da fase de forma robusta
    PHASE=$(grep -o '"current_phase": *[0-9]*' "$STATE_FILE" | grep -o '[0-9]*' | head -n 1)
    if [ -z "$PHASE" ]; then PHASE=0; fi
fi

# Lê o payload do stdin passado pelo Gemini CLI
PAYLOAD=$(cat)

# Usa grep e cut básico para extrair o file_path (compatível com POSIX)
FILE_PATH=$(echo "$PAYLOAD" | grep -o '"file_path": *"[^"]*"' | cut -d'"' -f4 | head -n 1)

# Regras da Máquina de Estados
if [ -n "$FILE_PATH" ]; then
    # 1. Regra de Proteção do Código-Fonte (Somente Fase 5)
    # Se o arquivo NÃO estiver em docs/, .gemini/, scripts/ ou for um arquivo de configuração raiz...
    if [[ ! "$FILE_PATH" == *"docs/"* ]] && [[ ! "$FILE_PATH" == *".gemini/"* ]] && [[ ! "$FILE_PATH" == *"scripts/"* ]] && [[ ! "$FILE_PATH" == "GEMINI.md" ]] && [[ ! "$FILE_PATH" == "gemini.toml" ]] && [[ ! "$FILE_PATH" == "README.md" ]] && [[ ! "$FILE_PATH" == "package.json" ]]; then
        
        # E a fase for menor que 5...
        if [ "$PHASE" -lt 5 ]; then
            echo "[ERROR] FSM: Tentativa de codificação prematura detectada." >&2
            cat <<EOF
{
  "status": "rejected",
  "reason": "FSM BLOCK: O projeto está atualmente na Fase $PHASE. Você tentou modificar um arquivo de código ('$FILE_PATH'). A escrita de código-fonte é ESTRITAMENTE PROIBIDA antes da Fase 5 (Construção). Siga o pipeline SDD e avance as fases usando 'bash scripts/change-phase.sh $PHASE' (e para as próximas) adequadamente."
}
EOF
            exit 2
        fi
    fi
    
    # 2. Regra de Proteção da Especificação (Somente a partir da Fase 2)
    if [[ "$FILE_PATH" == *"docs/specs/"* ]] && [[ "$PHASE" -lt 2 ]]; then
        echo "[ERROR] FSM: Tentativa de criar especificação fora da Fase 2." >&2
        cat <<EOF
{
  "status": "rejected",
  "reason": "FSM BLOCK: Você tentou criar/editar uma especificação ('$FILE_PATH') mas o projeto está na Fase $PHASE. Avance para a Fase 2 via 'scripts/change-phase.sh 2' antes de gerar especificações."
}
EOF
        exit 2
    fi
fi

echo "[SUCCESS] Ação permitida pela FSM na Fase $PHASE." >&2
cat <<EOF
{
  "status": "approved"
}
EOF
exit 0
