# Checklist de Verificação de Contexto (SDO)

Ao iniciar qualquer tarefa, execute este checklist para garantir que o contexto esteja correto e completo.

## 1. Identificação de Precedentes (Who else does this?)
- [ ] Realizou busca por classes/funções similares no repositório?
- [ ] Identificou quais módulos/camadas serão afetados?
- [ ] Há alguma API ou DTO já pronto que possa ser reutilizado?

## 2. Padrões Arquiteturais (How do we do things here?)
- [ ] O padrão de nomeação de arquivos segue o projeto?
- [ ] Como são tratados os logs de erro neste contexto?
- [ ] Existe uma estratégia de testes pré-definida para este tipo de componente?

## 3. Regras de Negócio Globais (Am I breaking anything?)
- [ ] Verificou o `SYSTEM_SPECIFICATION.md` para conflitos?
- [ ] Há regras de segurança ou isolamento de dados específicas para este domínio?
- [ ] Alguma mudança de estado financeiro está sendo proposta? (Se sim, use imutabilidade).

## 4. Auditoria de Dependências (What do I need to run this?)
- [ ] Todas as dependências externas necessárias já estão instaladas?
- [ ] O banco de dados exige alguma configuração prévia?
- [ ] O "Harness" de teste (scripts/hooks) está funcional para este módulo?

---
*Dica do Orquestrador: Se o contexto estiver nebuloso, use o comando `/analyze-project` ou peça mais detalhes ao usuário antes de prosseguir para a Fase 2.*
