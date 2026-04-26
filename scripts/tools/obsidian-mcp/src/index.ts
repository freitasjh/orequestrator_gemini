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
    name: "obsidian-brain-robust",
    version: "2.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

/**
 * Auxiliar: Extrai frontmatter e conteúdo
 */
function parseNote(content: string) {
  const frontmatterRegex = /^---\s*\n([\s\S]*?)\n---\s*\n([\s\S]*)$/;
  const match = content.match(frontmatterRegex);
  if (match) {
    return {
      metadata: match[1],
      body: match[2]
    };
  }
  return { metadata: "", body: content };
}

/**
 * Auxiliar: Normaliza string para busca fuzzy simples
 */
function normalize(str: string): string {
  return str.toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");
}

/**
 * Ferramenta: list_notes
 */
async function listNotes(dirPath: string = ""): Promise<string[]> {
  const fullPath = path.join(VAULT_ROOT, dirPath);
  try {
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
  } catch { return []; }
}

/**
 * Ferramenta: robust_search (Com Ranking)
 */
async function robustSearch(query: string): Promise<string> {
  const allNotes = await listNotes();
  const searchResults: { note: string; score: number; excerpt: string }[] = [];
  const normalizedQuery = normalize(query);
  
  for (const note of allNotes) {
    const content = await fs.readFile(path.join(VAULT_ROOT, note), "utf-8");
    const { metadata, body } = parseNote(content);
    const normalizedBody = normalize(body);
    const normalizedNoteName = normalize(note);
    
    let score = 0;
    
    // Peso 10: Título/Nome do arquivo
    if (normalizedNoteName.includes(normalizedQuery)) score += 10;
    
    // Peso 5: Metadados/Tags
    if (normalize(metadata).includes(normalizedQuery)) score += 5;
    
    // Peso 1: Conteúdo (com multiplicador de frequência)
    const occurrences = (normalizedBody.split(normalizedQuery).length - 1);
    score += occurrences;

    if (score > 0) {
      const index = normalizedBody.indexOf(normalizedQuery);
      const start = Math.max(0, index - 100);
      const end = Math.min(body.length, index + normalizedQuery.length + 100);
      const excerpt = "..." + body.substring(start, end).replace(/\n/g, " ") + "...";
      searchResults.push({ note, score, excerpt });
    }
  }
  
  searchResults.sort((a, b) => b.score - a.score);
  
  const formatted = searchResults.slice(0, 10).map(res => 
    `### [[${res.note.replace(".md", "")}]] (Score: ${res.score})\n> ${res.excerpt}\n`
  );

  return searchResults.length > 0 
    ? `## Resultados (Top 10):\n\n${formatted.join("\n")}`
    : `❌ Sem resultados para "${query}".`;
}

/**
 * Ferramenta: find_by_tags
 */
async function findByTags(tags: string[]): Promise<string> {
  const allNotes = await listNotes();
  const matches: string[] = [];
  
  for (const note of allNotes) {
    const content = await fs.readFile(path.join(VAULT_ROOT, note), "utf-8");
    const { metadata } = parseNote(content);
    if (tags.every(tag => metadata.includes(tag))) {
      matches.push(`- [[${note.replace(".md", "")}]]`);
    }
  }
  
  return matches.length > 0 
    ? `## Notas com as tags [${tags.join(", ")}]:\n\n${matches.join("\n")}`
    : `❌ Nenhuma nota encontrada com esse conjunto de tags.`;
}

// Registro de Ferramentas
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: "list_notes",
        description: "Lista todas as notas disponíveis.",
        inputSchema: { type: "object", properties: {} },
      },
      {
        name: "read_note",
        description: "Lê o conteúdo de uma nota.",
        inputSchema: {
          type: "object",
          properties: { path: { type: "string" } },
          required: ["path"],
        },
      },
      {
        name: "search_notes",
        description: "Busca robusta com ranking de relevância.",
        inputSchema: {
          type: "object",
          properties: { query: { type: "string" } },
          required: ["query"],
        },
      },
      {
        name: "find_by_tags",
        description: "Busca notas que contenham TODAS as tags fornecidas.",
        inputSchema: {
          type: "object",
          properties: { 
            tags: { type: "array", items: { type: "string" }, description: "Ex: ['eng/arch', 'status/stable']" } 
          },
          required: ["tags"],
        },
      },
      {
        name: "update_note",
        description: "Cria ou atualiza nota com suporte a Frontmatter.",
        inputSchema: {
          type: "object",
          properties: {
            path: { type: "string" },
            content: { type: "string" }
          },
          required: ["path", "content"],
        },
      },
    ],
  };
});

// Handler Simplificado
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  try {
    switch (name) {
      case "list_notes": return { content: [{ type: "text", text: (await listNotes()).join("\n") }] };
      case "read_note": {
        const { path: p } = z.object({ path: z.string() }).parse(args);
        return { content: [{ type: "text", text: await fs.readFile(path.join(VAULT_ROOT, p), "utf-8") }] };
      }
      case "search_notes": {
        const { query } = z.object({ query: z.string() }).parse(args);
        return { content: [{ type: "text", text: await robustSearch(query) }] };
      }
      case "find_by_tags": {
        const { tags } = z.object({ tags: z.array(z.string()) }).parse(args);
        return { content: [{ type: "text", text: await findByTags(tags) }] };
      }
      case "update_note": {
        const { path: p, content } = z.object({ path: z.string(), content: z.string() }).parse(args);
        const fullPath = path.join(VAULT_ROOT, p);
        await fs.mkdir(path.dirname(fullPath), { recursive: true });
        await fs.writeFile(fullPath, content, "utf-8");
        return { content: [{ type: "text", text: `Nota "${p}" salva.` }] };
      }
      default: throw new Error("Tool not found");
    }
  } catch (e: any) {
    return { content: [{ type: "text", text: `Erro: ${e.message}` }], isError: true };
  }
});

const transport = new StdioServerTransport();
server.connect(transport).catch(console.error);
