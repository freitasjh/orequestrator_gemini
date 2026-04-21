# Guia Avançado: Headless QA e Validação Estática (SAST)

Para que o Orquestrador atue como um verdadeiro *Headless Engineer* de nível sênior, ele não pode depender apenas de testes unitários básicos ou da "opinião" dos subagentes revisores (`@backend-code-reviewer`, etc.). Precisamos plugar ferramentas industriais de validação de código e testes automatizados de ponta a ponta (QA) no pipeline SDD.

Este documento detalha como evoluir a **Fase 5 (Construção / Self-Healing)** e a **Fase 6 (Quality Gate)**.

---

## 1. Integração com SonarQube / SAST (Análise Estática)

O objetivo aqui é tirar a subjetividade da revisão de código. Se o código tem "Code Smells", bugs estruturais ou vulnerabilidades, o SonarQube deve gritar e o hook deve forçar o agente a corrigir antes de pedir aprovação.

### Passo 1: Configurar a Ferramenta Localmente
Você precisa de um analisador estático que rode via CLI e exporte resultados em JSON ou texto estruturado.
- **Backend (Java):** `mvn sonar:sonar` (requer servidor Sonar local/Docker) ou ferramentas offline como `checkstyle` e `spotbugs`.
- **Frontend (TS/JS):** `eslint --format json` (obrigatório) ou Sonar Scanner CLI.
- **Python:** `ruff check --output-format json` ou `pylint -f json`.

### Passo 2: Evoluir o `post-construction.sh` (Self-Healing Avançado)
Atualmente, nosso hook de auto-cura apenas roda os testes unitários. Vamos adicionar a validação do Sonar/Linter.

**Exemplo de adaptação no `scripts/hooks/post-construction.sh` (Para Frontend TS):**

```bash
# ... (código existente do hook) ...

echo "[INFO] Rodando Análise Estática (ESLint Strict)..." >&2

# Executa o linter e exporta para JSON
npm run lint -- --format json > lint_report.json || true

# Conta quantos erros existem (usando jq, uma ferramenta essencial de terminal)
ERROR_COUNT=$(jq '[.[].errorCount] | add' lint_report.json)

if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "[ERROR] Code Smells detectados." >&2
    
    # Extrai apenas as mensagens cruciais para não estourar os tokens do LLM
    RESUMO_ERROS=$(jq -r '.[] | select(.errorCount > 0) | "\(.filePath): \(.messages[].message) (Linha \(.messages[].line))"' lint_report.json | head -n 5)
    
    cat <<EOF
{
  "status": "rejected",
  "reason": "Análise estática reprovou o código. $ERROR_COUNT erros encontrados. Primeiros 5 erros: $RESUMO_ERROS. Corrija essas violações arquiteturais imediatamente."
}
EOF
    rm lint_report.json
    exit 2
fi
```

**Como isso melhora o Headless:** O agente tenta entregar um código com variável não utilizada ou complexidade ciclomática alta. O CLI roda o lint, extrai exatamente a linha do erro via `jq` e devolve um JSON mastigado para o LLM: *"Faltou tipagem estrita na linha 42"*. O agente conserta sem você precisar intervir.

---

## 2. QA Automatizado: Validação de Issues (E2E / Integration)

Como garantir que a Issue "Criar Login" realmente funciona sem abrir o navegador?

### Estratégia: Test-Driven Issue Validation (TDIV)

A regra de ouro de um projeto headless robusto é: **O teste E2E ou de Integração define o fim da Issue.**

#### Para Backend (Testcontainers / Postman CLI / REST Assured)
1. **Padrão de Nomenclatura:** Se a issue é `ISSUE_042.md`, o agente `@backend-specialist` DEVE escrever um teste de integração nomeado `Issue042IntegrationTest.java` (ou equivalente).
2. **Quality Gate Hook (`quality-gate.sh`):** Modifique este hook para, além de checar o `BOARD.md`, procurar e executar especificamente a suíte de testes atrelada à Issue ativa listada no `.gemini/STATE.json`.

**Exemplo no `quality-gate.sh`:**
```bash
# ...
ACTIVE_ISSUE=$(grep -o '"active_issue": *"[^"]*"' "$GEMINI_PROJECT_DIR/.gemini/STATE.json" | cut -d'"' -f4)

echo "[QA] Verificando Testes de Aceitação para $ACTIVE_ISSUE..." >&2

# Tenta rodar especificamente a suíte de testes com o nome da Issue
if ! mvn test -Dtest="*${ACTIVE_ISSUE}*" > qa_report.log 2>&1; then
    # Falhou no teste que valida a issue inteira
    cat <<EOF
{
  "status": "rejected",
  "reason": "QA FAILED: Os testes de aceitação da $ACTIVE_ISSUE falharam. Revise a implementação para garantir que todos os critérios da especificação foram atendidos."
}
EOF
    exit 2
fi
```

#### Para Frontend (Cypress / Playwright Headless)
Você não precisa de interface gráfica. O Cypress e o Playwright rodam perfeitamente em modo *headless* no terminal.

1.  O agente `@frontend-specialist` escreve a tela e um arquivo `issue_042.cy.ts`.
2.  O hook `quality-gate.sh` roda: `npx cypress run --spec "**/*${ACTIVE_ISSUE}*"`
3.  Se o robô do Cypress não conseguir clicar no botão de login (porque o botão não está lá ou a tela quebrou), o hook falha, envia o erro do terminal do Cypress (ex: *"Elemento #btn-login não encontrado"*) de volta em JSON para o LLM.
4.  O agente `@frontend-specialist` lê o erro do Cypress, reabre o componente Vue/React, adiciona o ID correto no botão e salva. O loop reinicia e agora passa.

---

## Resumo Arquitetural para Implementação

Para que isso rode liso no seu projeto:

1.  **Escolha o seu Linter Primário:** (ex: Ruff para Python, ESLint para JS, ArchUnit para Java) e configure-o para exportar a saída em JSON.
2.  **Instale o `jq`:** Se usar Linux/Mac, o utilitário `jq` é vital para os scripts bash parsearem os JSONs dos linters sem precisar de Python.
3.  **Refatore os Hooks:** Aplique a lógica do `ERROR_COUNT` no seu `post-construction.sh`.
4.  **Crie um "Contrato de QA":** Atualize o seu `[[SYSTEM_SPECIFICATION]].md` informando aos agentes que *"Toda issue concluída DEVE ter um teste E2E ou de Integração cujo nome do arquivo contenha o número da Issue (ex: ISSUE_001_Test.ts)"*. O Quality Gate cuidará do resto.