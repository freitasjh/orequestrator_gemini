#!/bin/bash
# Hook Nativo: Post-Construction Validation (Self-Healing Ready)
# Este hook é executado automaticamente pelo Gemini CLI (AfterTool) 
# sempre que as ferramentas de edição de código (write_file, replace) são usadas.

# Regra de Ouro: Todo log visual deve ir para o STDERR. 
# O STDOUT deve conter APENAS o JSON final lido pelo Gemini CLI.

echo "[INFO] Iniciando validação de construção nativa em background..." >&2

# Captura erros em um arquivo temporário
TMP_ERROR_FILE=$(mktemp)

# Variável de controle
SUCCESS=true

# --- Exemplo de validação Node.js ---
# if [ -f "package.json" ]; then
#     echo "[NODE] Executando testes e lint..." >&2
#     
#     # Roda o lint e captura o erro se falhar
#     if ! npm run lint > "$TMP_ERROR_FILE" 2>&1; then
#         SUCCESS=false
#     fi
#
#     # Roda testes apenas se o lint passar
#     if $SUCCESS; then
#         if ! npm run test > "$TMP_ERROR_FILE" 2>&1; then
#             SUCCESS=false
#         fi
#     fi
# fi

# --- Template Atual Simulando Sucesso (Adapte para sua stack) ---
# Substitua esse trecho pela execução real da sua ferramenta de CI local
# echo "[INFO] Hook executando template básico (simulação)." >&2

# Se houve falha, retorna código 2 e um JSON informando o erro
if [ "$SUCCESS" = false ]; then
    ERROR_MSG=$(cat "$TMP_ERROR_FILE" | tr '\n' ' ' | sed 's/"/\\"/g') # Escape simples para JSON
    
    echo "[ERROR] Falha na validação." >&2
    
    # Cospe o JSON estruturado no stdout
    cat <<EOF
{
  "status": "rejected",
  "reason": "O hook de post-construction falhou com os seguintes erros: $ERROR_MSG. Corrija o código antes de pedir revisão."
}
EOF
    rm -f "$TMP_ERROR_FILE"
    exit 2 # Código 2 bloqueia o fluxo e injeta o erro no contexto do agente
fi

# Se sucesso, retorna código 0 e um JSON vazio (ou com metadados opcionais)
echo "[SUCCESS] Validação concluída com sucesso." >&2
cat <<EOF
{
  "status": "approved",
  "message": "Qualidade do código validada via hook nativo."
}
EOF

rm -f "$TMP_ERROR_FILE"
exit 0
