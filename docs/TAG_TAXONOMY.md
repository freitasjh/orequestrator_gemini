# 🏷️ Taxonomia de Tags (Cérebro Digital)

Este documento define as tags obrigatórias para organização do conhecimento no Obsidian. Agentes e humanos devem seguir este padrão para garantir que o RAG seja assertivo.

## 📌 Categorias Principais

### 1. Camadas de Engenharia (#eng/...)
- `#eng/arch`: Decisões arquiteturais, padrões e diagramas.
- `#eng/backend`: Lógica de servidor, APIs, Bancos de Dados.
- `#eng/frontend`: UI, UX, Componentes, Design System.
- `#eng/security`: Práticas de segurança, auditorias, OWASP.
- `#eng/qa`: Estratégias de teste, planos e automação.

### 2. Estado do Conhecimento (#status/...)
- `#status/draft`: Conhecimento em fase de pesquisa ou incompleto.
- `#status/stable`: Conhecimento validado e pronto para uso.
- `#status/deprecated`: Padrões antigos que não devem mais ser seguidos.

### 3. Tipo de Nota (#type/...)
- `#type/adr`: Architectural Decision Records.
- `#type/pattern`: Padrões de design ou snippets de código.
- `#type/lesson`: Lições aprendidas de erros ou sucessos passados.
- `#type/spec`: Especificações técnicas de funcionalidades.
- `#type/tool`: Documentação de ferramentas externas ou internas.

### 4. Domínio de Negócio (#biz/...)
- `#biz/core`: Regras fundamentais do negócio.
- `#biz/integration`: Regras de integração com terceiros.

## 🛠️ Como usar no Markdown (Frontmatter)

Todas as notas **DEVEM** começar com o seguinte bloco:

```yaml
---
tags: [eng/arch, type/pattern, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
last_reviewed: 2024-04-24
---
```

## 🔍 Regra para o Agente (RAG)
Antes de realizar uma busca global, o agente deve:
1. Listar notas que contenham a tag da categoria relacionada.
2. Priorizar notas no diretório `docs/lessons/` para entender precedentes.
3. Se não encontrar, expandir para a busca por palavra-chave.
