"use strict";
import * as vscode from "vscode";
import { SymbolInfo, SymbolType } from "./SymbolInfo";
import { DocumentSymbolManager } from "./DocumentManager";

export const wordPatternRegExp = /(\#\d*)|(-?\d*\.\d\w*)|([^\`\~\!\@\#\%\^\&\*\(\)\-\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/;

const noLeadingZeroRegEx = /^[A-Z](\d)$/;
/**
 * Normalize the name of a gcode symbol
 * @param symbolName - symbol to normaize
 */
export function normalizeSymbolName(symbolName: string): string {
  let upperName = symbolName.toUpperCase().trim();
  let matches;
  // Convert all non-leading zero forms (G1, G2) to leading zero forms for symbol name
  if ((matches = noLeadingZeroRegEx.exec(upperName))) {
    let number = parseInt(matches[1]);
    upperName = `${upperName[0]}0${number}`;
  }
  return upperName;
}

/**
 * Return a regular expression that matches any of the input regular expressions
 * @param args - Regular expressions to combine
 */
export function RegExpAny(...args: RegExp[]) {
  let components: string[] = [];
  let flags = new Map();
  for (let i = 0; i < args.length; i++) {
    components.push(args[i].source);
    for (let flag of args[i].flags.split("")) {
      flags.set(flag, flag);
    }
  }
  let newFlags = [];
  for (let key of flags.keys()) {
    newFlags.push(key);
  }
  let combined = new RegExp(
    `(?:${components.join(")|(?:")})`,
    newFlags.join("")
  );
  return combined;
}

/**
 * Return symbol information (if we have any) for a given name in the document.
 *
 * @param document - VSCode document the symbol is in.
 * @param symbolName - Symbol to try to find information about.
 */
export function getSymbolByName(
  document: vscode.TextDocument,
  symbolName: string
): SymbolInfo | null {
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
