#!/bin/bash
# Ferramenta de Arquivamento de Board (Prevenção de Token Bloat)
# Move issues marcadas como DONE no BOARD.md para um arquivo de histórico.
# Uso: bash scripts/tools/archive-done-issues.sh

BOARD="docs/backlog/BOARD.md"
ARCHIVE="docs/backlog/BOARD_ARCHIVE.md"
ARCHIVE_DIR="docs/backlog/archive"

mkdir -p "$ARCHIVE_DIR"

if [ ! -f "$BOARD" ]; then
  echo "❌ BOARD.md não encontrado."
  exit 1
fi

if [ ! -f "$ARCHIVE" ]; then
  echo "# Histórico de Tarefas Concluídas (Archived)" > "$ARCHIVE"
  echo "" >> "$ARCHIVE"
fi

echo "🧹 Iniciando limpeza do BOARD.md..."

# 1. Extrai todas as linhas que contêm "[DONE]" ou similar (ajuste o regex conforme o padrão visual do seu board)
# Assumindo formato Markdown com checkboxes "- [x]" ou colunas explicitas "| DONE |"
# Vamos procurar por issues marcadas como concluídas (ex: ISSUE_001.md - DONE)
DONE_ISSUES=$(grep -E -i "\[x\]|DONE" "$BOARD" | grep -oE "ISSUE_[0-9]+")

if [ -z "$DONE_ISSUES" ]; then
  echo "Nenhuma tarefa concluída encontrada para arquivamento."
  exit 0
fi

for ISSUE in $DONE_ISSUES; do
  echo "📦 Arquivando $ISSUE..."
  
  # Adiciona ao arquivo morto
  grep -i "$ISSUE" "$BOARD" >> "$ARCHIVE"
  
  # Remove do Board principal (usa sed para deletar a linha in-place)
  sed -i "/$ISSUE/d" "$BOARD"
  
  # Move o arquivo da issue para a pasta archive
  if [ -f "docs/backlog/$ISSUE.md" ]; then
    mv "docs/backlog/$ISSUE.md" "$ARCHIVE_DIR/"
  elif [ -f "docs/backlog/${ISSUE}_"*.md ]; then
     mv docs/backlog/${ISSUE}_*.md "$ARCHIVE_DIR/"
  fi
done

echo "✅ Limpeza concluída. O BOARD.md foi reduzido para economizar contexto."
