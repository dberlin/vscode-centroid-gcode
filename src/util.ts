"use strict";
import * as vscode from "vscode";
import { SymbolInfo, SymbolType } from "./SymbolInfo";
import { DocumentSymbolManager } from "./DocumentManager";

/**
 * Return symbol information (if we have any) for a given name in the document.
 *
 * @param document - VSCode document the symbol is in.
 * @param symbolName - Symbol to try to find information about.
 */
export function getSymbolByName(
  document: vscode.TextDocument,
  symbolName: string
) {
  let tries = DocumentSymbolManager.getTriesForDocument(document);
  if (!tries) return null;
  return tries.getSymbol(symbolName);
}

/**
 * Convert a (document, position) pair into a word in the document.
 *
 * @param document - VSCode document the position is for.
 * @param position - Position in document to get word for.
 */
export function getWordForPosition(
  document: vscode.TextDocument,
  position: vscode.Position
): string | null {
  let wordRange = document.getWordRangeAtPosition(position);
  if (!wordRange) {
    return null;
  }
  return document.getText(wordRange);
}

/**
 * Return symbol information (if we have any) for a given position in the document.
 *
 * @param document - VSCode document the position is for.
 * @param position - Position in document to get symbol for.
 */
export function getSymbolForPosition(
  document: vscode.TextDocument,
  position: vscode.Position
): SymbolInfo | null {
  let wordText = getWordForPosition(document, position);
  if (!wordText) return null;
  return getSymbolByName(document, wordText);
}
