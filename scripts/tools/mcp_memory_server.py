import sqlite3
import os
import json
from mcp.server.fastmcp import FastMCP
from sentence_transformers import SentenceTransformer

# Inicializa o MCP Server
mcp = FastMCP("SdoMemoryServer")

# Inicializa o modelo de embeddings (Roda localmente, ~80MB)
# Nota: Na primeira execução, o download do modelo pode demorar alguns segundos.
print("Loading Embedding Model...", flush=True)
model = SentenceTransformer('all-MiniLM-L6-v2')

# Caminho para o banco de dados
DB_PATH = os.path.join(os.getcwd(), 'docs/product/memory.sqlite')
os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

def init_db():
    conn = sqlite3.connect(DB_PATH)
    # Tabela simples para armazenamento (Pode evoluir para sqlite-vss depois se necessário)
    conn.execute("CREATE TABLE IF NOT EXISTS memory_text (id INTEGER PRIMARY KEY, content TEXT, source TEXT, vector TEXT)")
    conn.commit()
    return conn

@mcp.tool()
def search_memory(query: str, limit: int = 3) -> str:
    """Busca o histórico e lições aprendidas do projeto por similaridade semântica (RAG)."""
    query_vector = model.encode(query).tolist()
    
    conn = init_db()
    cursor = conn.cursor()
    cursor.execute("SELECT content, source, vector FROM memory_text")
    rows = cursor.fetchall()
    
    if not rows:
        return "Nenhuma informação relevante encontrada na memória."
    
    # Simulação de busca vetorial (Cosine Similarity manual para evitar dependência de extensões nativas complexas em setup inicial)
    import numpy as np
    def cosine_similarity(v1, v2):
        return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))
    
    scored_results = []
    qv = np.array(query_vector)
    for content, source, vector_str in rows:
        v = np.array(json.loads(vector_str))
        score = cosine_similarity(qv, v)
        scored_results.append((content, source, score))
    
    # Ordena por score descendente
    scored_results.sort(key=lambda x: x[2], reverse=True)
    results = scored_results[:limit]
        
    response = f"Contexto Recuperado para '{query}':\n"
    for content, source, score in results:
         response += f"[{source}] (Score: {score:.4f}): {content}\n---\n"
         
    return response

@mcp.tool()
def add_memory(content: str, source: str) -> str:
    """Adiciona uma nova lição ou regra ao banco vetorial de aprendizado."""
    vector = model.encode(content).tolist()
    conn = init_db()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO memory_text (content, source, vector) VALUES (?, ?, ?)", 
                   (content, source, json.dumps(vector)))
    conn.commit()
    rowid = cursor.lastrowid
    return f"Memória adicionada com sucesso (ID: {rowid})."

if __name__ == "__main__":
    mcp.run()
