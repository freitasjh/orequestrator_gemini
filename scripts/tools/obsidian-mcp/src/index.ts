#!/usr/bin/env node
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { z } from "zod";
import fs from "fs/promises";
import path from "path";
import { fileURLToPath } from "url";

// Configurações do Vault
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const VAULT_ROOT = path.resolve(__dirname, "../../../../docs");

const server = new Server(
  {
    name: "obsidian-brain",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

/**
 * Ferramenta: list_notes
 */
async function listNotes(dirPath: string = ""): Promise<string[]> {
  const fullPath = path.join(VAULT_ROOT, dirPath);
  const entries = await fs.readdir(fullPath, { withFileTypes: true });
  
  let notes: string[] = [];
  for (const entry of entries) {
    const relativePath = path.join(dirPath, entry.name);
    if (entry.isDirectory()) {
      const subNotes = await listNotes(relativePath);
      notes = notes.concat(subNotes);
    } else if (entry.name.endsWith(".md")) {
      notes.push(relativePath);
    }
  }
  return notes;
}

/**
 * Ferramenta: search_notes
 */
async function searchNotes(query: string): Promise<string> {
  const allNotes = await listNotes();
  const results: string[] = [];
  
  for (const note of allNotes) {
    const content = await fs.readFile(path.join(VAULT_ROOT, note), "utf-8");
    if (content.toLowerCase().includes(query.toLowerCase())) {
      const excerpt = content.substring(0, 200).replace(/\n/g, " ") + "...";
      results.push(`- [[${note.replace(".md", "")}]]: ${excerpt}`);
    }
  }
  
  return results.length > 0 
    ? `Resultados para "${query}":\n\n${results.join("\n")}`
    : `Nenhuma nota encontrada com o termo "${query}".`;
}

// Registro de Ferramentas
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: "list_notes",
        description: "Lista todas as notas (arquivos .md) disponíveis no Vault.",
        inputSchema: { type: "object", properties: {} },
      },
      {
        name: "read_note",
        description: "Lê o conteúdo de uma nota específica pelo seu caminho relativo.",
        inputSchema: {
          type: "object",
          properties: {
            path: { type: "string", description: "Caminho relativo da nota (ex: product/ARCHITECTURE.md)" },
          },
          required: ["path"],
        },
      },
      {
        name: "search_notes",
        description: "Busca por um termo ou palavra-chave em todas as notas do Vault.",
        inputSchema: {
          type: "object",
          properties: {
            query: { type: "string", description: "Termo de busca" },
          },
          required: ["query"],
        },
      },
      {
        name: "update_note",
        description: "Atualiza ou cria uma nota com novo conteúdo.",
        inputSchema: {
          type: "object",
          properties: {
            path: { type: "string", description: "Caminho relativo da nota" },
            content: { type: "string", description: "Conteúdo completo da nota em Markdown" },
          },
          required: ["path", "content"],
        },
      },
    ],
  };
});

// Handlers das Ferramentas
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  try {
    switch (name) {
      case "list_notes": {
        const notes = await listNotes();
        return { content: [{ type: "text", text: notes.join("\n") }] };
      }

      case "read_note": {
        const { path: notePath } = z.object({ path: z.string() }).parse(args);
        const fullPath = path.join(VAULT_ROOT, notePath);
        const content = await fs.readFile(fullPath, "utf-8");
        return { content: [{ type: "text", text: content }] };
      }

      case "search_notes": {
        const { query } = z.object({ query: z.string() }).parse(args);
        const result = await searchNotes(query);
        return { content: [{ type: "text", text: result }] };
      }

      case "update_note": {
        const { path: notePath, content } = z.object({ path: z.string(), content: z.string() }).parse(args);
        const fullPath = path.join(VAULT_ROOT, notePath);
        await fs.mkdir(path.dirname(fullPath), { recursive: true });
        await fs.writeFile(fullPath, content, "utf-8");
        return { content: [{ type: "text", text: `Nota "${notePath}" atualizada com sucesso.` }] };
      }

      default:
        throw new Error(`Ferramenta desconhecida: ${name}`);
    }
  } catch (error: any) {
    return {
      content: [{ type: "text", text: `Erro: ${error.message}` }],
      isError: true,
    };
  }
});

// Inicialização
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("Obsidian Brain MCP Server running on stdio");
}

main().catch((error) => {
  console.error("Fatal error in main():", error);
  process.exit(1);
});
