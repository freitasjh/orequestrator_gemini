# Lessons Learned

Este arquivo contém o histórico de erros arquiteturais e de implementação detectados durante o desenvolvimento. Estes erros NÃO devem ser repetidos.

*Instrução de Uso: Este arquivo é um template base. Conforme o projeto avança, documente aqui erros recorrentes, edge-cases da stack escolhida e decisões críticas para que os Agentes de IA e a equipe não repitam as mesmas falhas.*

### Arquitetura e Padrões Base
- **Sistematização de Regras:** Sempre que possível, converta as lições aprendidas aqui em regras automatizadas no pipeline CI/CD (ex: regras de linter, testes arquiteturais baseados na linguagem do projeto, detecção estática de vulnerabilidades). O objetivo é garantir que o build falhe caso a regra seja desrespeitada.
- **Auto-Cleanup:** Após sistematizar uma regra textualmente escrita aqui para o código do projeto (ex: via ESLint/Ruff/ArchUnit/Sonar), remova ou resuma a regra deste arquivo para poupar tokens de contexto da IA.
- **Validação de Inputs:** Nunca confie em dados recebidos do cliente. Sempre valide as entradas de dados na camada mais externa da aplicação antes de repassá-las para os serviços ou domínio.
- **Testes de Regressão:** Todo bug resolvido em produção deve vir acompanhado de um teste automatizado que reproduza a falha, garantindo que o problema não retorne no futuro.

### Frontend
- *(Preencha com lições do framework/linguagem de frontend definido no PROJECT_CONFIG.md)*

### Backend
- *(Preencha com lições do framework/linguagem de backend definido no PROJECT_CONFIG.md)*

### Infraestrutura e Banco de Dados
- *(Preencha com detalhes sobre deploys, migrations e peculiaridades do banco de dados)*
