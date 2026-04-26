---
name: sdo-context-manager
description: Gerencia o ciclo de vida do contexto (Fase 1) integrando buscas semânticas (MCP/RAG), análise de precedentes e poda de informações irrelevantes. Esta skill garante que o Orquestrador e os especialistas tenham a "Single Source of Truth" do projeto antes de qualquer modificação.
---

# SDO Context Manager (RAG-Ready)

## Visão Geral
Esta skill é o "Cerebro de Conhecimento" do SDO. Ela evita alucinações e redundâncias ao garantir que o agente entenda o que já existe no sistema (Precedentes) e como as regras de negócio globais impactam a tarefa atual.

## Workflow de Context Engineering (Fase 1)

### 1. Descoberta Semântica (Obsidian-First)
Sempre que uma nova tarefa for iniciada, a skill OBRIGA a consulta ao "Cérebro" do projeto (Obsidian) via MCP:
- **Consulta à Taxonomia:** Leia sempre `docs/TAG_TAXONOMY.md` para identificar quais categorias de tags são relevantes para a tarefa.
- **Busca por Tags:** Priorize ferramentas que filtrem por tags (ex: `#eng/arch`) para reduzir o ruído.
- **Busca de Lições Aprendidas:** Execute `mcp_ObsidianBrain_search_notes` com termos da tarefa para identificar erros que já ocorreram ou padrões de sucesso.

**DADO MANDATÓRIO:** A IA não pode avançar para a Fase 2 sem antes listar no Dashboard de Contexto pelo menos 2 lições aprendidas ou ADRs consultados no Obsidian.

### 2. Mapeamento de Precedentes (Brownfield Analysis)
Antes de gerar o Blueprint (Fase 2), a skill exige o preenchimento de um `CONTEXT_REPORT.md` temporário:
- **Arquivos Relevantes:** Lista mínima de arquivos necessários para entender a lógica.
- **Padrões Identificados:** Nomenclatura, Estrutura de Pastas, Estilo de Testes.
- **Dívida Técnica Detectada:** Pontos que podem quebrar ou que precisam de refatoração prévia.

### 3. Context Pruning (Poda de Tokens)
Para manter a eficiência do contexto:
- **Extração Cirúrgica:** Leia apenas os métodos e assinaturas relevantes (`read_file` com ranges).
- **Sumarização de Código:** Substitua implementações longas por interfaces/pseudo-assinaturas se o objetivo for apenas entender a estrutura.

## Integração com a Tríade (Harness + SDD + RAG)
- **Harness:** O contexto deve incluir os comandos de teste atuais para garantir que o "Harness" de validação esteja pronto.
- **SDD:** O contexto alimenta o Blueprint com exemplos de código reais já existentes no projeto.
- **RAG (MCP):** O contexto é dinamicamente buscado no banco de vetores do projeto.

## Diretrizes de Uso
- **Pense antes de ler:** Use `grep_search` e busca semântica antes de abrir arquivos grandes.
- **Verdade Única:** O código atual é a verdade absoluta. Se a `ARCHITECTURE.md` diz X mas o código faz Y, reporte o conflito no Dashboard de Contexto.

## Recursos Bundled

### references/
- `context-check-checklist.md`: Itens obrigatórios para validar o contexto de uma task.
- `mcp-rag-integration-guide.md`: Como utilizar os comandos do MCP para buscas semânticas.
