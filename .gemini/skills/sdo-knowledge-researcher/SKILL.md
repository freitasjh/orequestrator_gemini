---
name: sdo-knowledge-researcher
description: Especialista em pesquisa autônoma, síntese de conhecimento técnico e expansão da base de conhecimento (Obsidian). Transforma temas genéricos em documentação estruturada e acionável.
---

# SDO Knowledge Researcher (Auto-Learning)

## Visão Geral
Esta skill transforma o Gemini CLI em um motor de aprendizado contínuo. Ela não apenas busca informações, mas as processa, valida contra múltiplas fontes e as organiza no Obsidian seguindo os padrões de documentação do projeto.

## Workflow de Aprendizado (Iterative Research)

### 1. Decomposição do Tema (Clarity Phase)
Ao receber um tema (ex: "Arquitetura Hexagonal com Spring Boot"):
- Identifique os pilares: Teoria, Implementação Prática, Prós/Contras, Ecossistema de Ferramentas.
- Crie um plano de pesquisa com pelo menos 3 sub-queries distintas.

### 2. Captura e Filtragem (Harvesting)
- **Busca Multimodal:** Use `google_web_search` para encontrar documentação oficial, artigos técnicos (Medium, Dev.to) e discussões (StackOverflow, Reddit).
- **Deep Read:** Use `web_fetch` nos links mais relevantes para extrair o conteúdo bruto.
- **Deteção de Ruído:** Descarte tutoriais obsoletos ou informações superficiais.

### 3. Síntese e Estruturação (Knowledge Engineering)
Organize o conhecimento capturado nos seguintes formatos:
- **Core Principles:** O que é fundamental.
- **Code Patterns:** Exemplos de código limpos e idiomáticos.
- **Trade-offs:** Quando usar e quando evitar.
- **Project Alignment:** Como isso se aplica especificamente ao nosso projeto atual?

### 4. Persistência no Obsidian (Brain Integration)
Salve os resultados em `docs/knowledge/{tema}/` seguindo rigorosamente a `docs/TAG_TAXONOMY.md`:
- **Frontmatter OBRIGATÓRIO:** Todas as notas devem conter YAML com `tags`, `related_notes` e `status`.
- `INDEX.md`: Mapa mental do tema e links para sub-notas.
- `CONCEPTUAL.md`: Teoria e fundamentos.
- `PRACTICAL.md`: Exemplos de implementação.
- `REFERENCES.md`: Lista de links consultados.

### 5. Ciclo de Refinamento (Self-Correction)
- Após a primeira rodada, pergunte-se: "Existe alguma lacuna que impediria um desenvolvedor de implementar isso hoje?". Se sim, realize uma nova iteração de busca.

## Diretrizes de Qualidade
- **I18n:** Documente sempre em português (pt_BR), mas pesquise em inglês para obter os resultados mais atualizados.
- **Neutralidade:** Apresente diferentes pontos de vista sobre tecnologias concorrentes.
- **Linkagem:** Sempre tente conectar o novo conhecimento a notas existentes no Obsidian (ADRs, System Specs).

## Recursos Bundled
### assets/templates/
- `KNOWLEDGE_NOTE_TEMPLATE.md`: Template padrão para notas de conhecimento.
