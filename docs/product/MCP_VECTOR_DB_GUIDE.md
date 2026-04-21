# Guia: Obsidian como Cérebro Digital (MCP + TypeScript)

Este projeto utiliza o **Obsidian** como sua base de conhecimento e "cérebro" central. Em vez de um banco de dados vetorial proprietário ou opaco, utilizamos arquivos Markdown locais que podem ser editados tanto por humanos quanto por IAs.

## A Arquitetura

Utilizamos um Servidor MCP (Model Context Protocol) desenvolvido em **TypeScript** que atua como uma interface "headless" para o diretório `docs/`.

### Vantagens:
- **Human-in-the-Loop:** Você pode abrir a pasta `docs/` no Obsidian e organizar o conhecimento visualmente.
- **Transparência:** Todo o histórico e regras de negócio estão em texto plano (Markdown).
- **Headless:** O servidor MCP funciona sem a necessidade de o aplicativo Obsidian estar aberto.

## Como Funciona

O servidor MCP está localizado em `scripts/tools/obsidian-mcp/` e expõe as seguintes ferramentas para o Orquestrador:

1.  **`list_notes`**: Mapeia todo o conhecimento disponível no Vault.
2.  **`read_note`**: Lê o conteúdo técnico de uma especificação ou regra.
3.  **`search_notes`**: Realiza buscas por palavras-chave em toda a documentação.
4.  **`update_note`**: Permite à IA consolidar aprendizados e atualizar as lições aprendidas (`[[[[[[LESSONS_LEARNED]]]]]].md`).

## Configuração do Servidor

O servidor é registrado no arquivo `.gemini/settings.json`:

```json
{
  "mcp": {
    "servers": {
      "ObsidianBrain": {
        "command": "node",
        "args": ["/caminho/para/scripts/tools/obsidian-mcp/build/index.js"]
      }
    }
  }
}
```

## Fluxo de Trabalho (SDO)

- **Fase 1 (Context Check):** O especialista de contexto utiliza `search_notes` para garantir que a nova tarefa não viole decisões arquiteturais anteriores.
- **Fase 8 (Consolidação):** Após a conclusão de uma tarefa, o Orquestrador utiliza `update_note` para gravar novas lições aprendidas no Vault, garantindo que o sistema "evolua".
