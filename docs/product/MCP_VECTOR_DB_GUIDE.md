# Guia: Como implementar RAG com MCP, Python e SQLite (Fase 2)

Este guia documenta o caminho definitivo para resolver o limite de tokens do Orquestrador: implementar um Servidor MCP (Model Context Protocol) que atua como um Banco de Dados Vetorial semântico local.

## A Arquitetura Proposta

Em vez do Gemini CLI ler o `LESSONS_LEARNED.md` inteiro, ele chamará uma ferramenta `search_memory(query="auth jwt")`. O servidor MCP vai calcular o embedding da query, buscar no SQLite os vetores mais próximos (Cosine Similarity) e retornar apenas os 3 parágrafos cruciais.

### 1. O Servidor MCP (Python)

Você precisará de um script Python rodando localmente. O protocolo MCP se comunica via `stdio` (entrada/saída padrão) em JSON-RPC.

**Bibliotecas Necessárias:**
```bash
pip install mcp sqlite-vss sentence-transformers
```

*   `mcp`: O SDK oficial do Anthropic/Google para criar servidores MCP.
*   `sqlite-vss`: Extensão do SQLite para busca vetorial rápida sem precisar subir um ChromaDB ou Pinecone pesado.
*   `sentence-transformers`: Para gerar embeddings locais na sua máquina (ex: modelo `all-MiniLM-L6-v2`) de forma rápida e sem custo de API.

### 2. Esboço do Código Python (`mcp_memory_server.py`)

```python
import sqlite3
import sqlite_vss
from mcp.server.fastmcp import FastMCP
from sentence_transformers import SentenceTransformer

# Inicializa o MCP Server
mcp = FastMCP("SdoMemoryServer")

# Inicializa o modelo de embeddings (Roda localmente, ~80MB)
model = SentenceTransformer('all-MiniLM-L6-v2')

# Conecta ao SQLite e carrega a extensão VSS
db = sqlite3.connect('docs/product/memory.sqlite')
db.enable_load_extension(True)
sqlite_vss.load(db)
db.execute("CREATE VIRTUAL TABLE IF NOT EXISTS vss_memory USING vss0(embedding(384))")
db.execute("CREATE TABLE IF NOT EXISTS memory_text (rowid INTEGER PRIMARY KEY, content TEXT, source TEXT)")
db.commit()

@mcp.tool()
def search_memory(query: str) -> str:
    """Busca o histórico e lições aprendidas do projeto por similaridade semântica."""
    # Gera o vetor da pergunta
    query_vector = model.encode(query).tolist()
    
    # Busca no SQLite-VSS
    cursor = db.cursor()
    cursor.execute("""
        SELECT t.content, t.source, v.distance 
        FROM vss_memory v 
        JOIN memory_text t ON v.rowid = t.rowid
        WHERE vss_search(v.embedding, ?)
        ORDER BY v.distance LIMIT 3
    """, (str(query_vector),))
    
    results = cursor.fetchall()
    
    if not results:
        return "Nenhuma informação relevante encontrada na memória."
        
    response = "Contexto Recuperado:\n"
    for content, source, _ in results:
         response += f"[{source}]: {content}\n---\n"
         
    return response

@mcp.tool()
def add_memory(content: str, source: str) -> str:
    """Adiciona uma nova lição ou regra ao banco vetorial."""
    vector = model.encode(content).tolist()
    cursor = db.cursor()
    cursor.execute("INSERT INTO memory_text (content, source) VALUES (?, ?)", (content, source))
    rowid = cursor.lastrowid
    cursor.execute("INSERT INTO vss_memory(rowid, embedding) VALUES (?, ?)", (rowid, str(vector)))
    db.commit()
    return f"Memória adicionada com sucesso (ID: {rowid})."

if __name__ == "__main__":
    mcp.run()
```

### 3. Integração com o Gemini CLI

Depois de ter o script Python pronto, você registra o servidor no `settings.json` (ou globalmente no Gemini CLI) na sessão de MCP:

```json
{
  "mcp": {
    "servers": {
      "SdoMemory": {
        "command": "python3",
        "args": ["/caminho/absoluto/para/mcp_memory_server.py"]
      }
    }
  }
}
```

### 4. Como o Pipeline SDD muda com isso?

*   O arquivo `LESSONS_LEARNED.md` e a pasta `specs/` antigas deixam de existir como texto plano injetado.
*   Na **Fase 1 (Context-Check)**: O `@context-backend` usaria automaticamente a ferramenta `search_memory("regras de backend")`.
*   Na **Fase 8 (Consolidação)**: O Orquestrador chamaria a ferramenta `add_memory` enviando o resumo dos erros corrigidos e decisões tomadas naquela Spec, consolidando o aprendizado no banco vetorial.

Dessa forma, o projeto pode ter 10.000 issues e anos de histórico de "Lessons Learned", e o LLM consumirá apenas algumas centenas de tokens cruciais e perfeitos para a task atual.