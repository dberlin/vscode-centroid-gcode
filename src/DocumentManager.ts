"use strict";
import * as path from "path";
import * as vscode from "vscode";
import { FileTries } from "./FileTries";
import help_text from "./json/help_text.json";
import machine_parameters from "./json/machine_parameters.json";
import macro_variables from "./json/macro_variables.json";
import { ModalManager } from "./ModalManager";
import { SymbolInfo, SymbolType } from "./SymbolInfo";

function convertKindtoSymbolType(kind: string) {
  switch (kind) {
    case "g-code":
      return SymbolType.GCode;
    case "m-code":
      return SymbolType.MCode;
    case "system-variable":
      return SymbolType.SystemVariable;
  }
  return SymbolType.OtherCode;
}

// This is the format the JSON files have
interface JSONSymbol {
  kind: string;
  detail: string;
  documentation: string;
  sortText: string;
  name: string;
}

/**
 * Main class handling managing open VSCode documents and associated symbols.
 */
class DocumentSymbolManagerClass {
  private modes: Map<string, ModalManager> = new Map<string, ModalManager>();
  private tries: Map<string, FileTries> = new Map<string, FileTries>();
  private systemSymbols: SymbolInfo[] = [];

  init(context: vscode.ExtensionContext) {
    this.processSymbolList(help_text);
    this.processSymbolList(machine_parameters);
    this.processSymbolList(<any>macro_variables);
  }

  /**
   * Take a list of JSOn symbols and convert them to VSCode SymbolInfo.
   *
   * @param symList - list of symbols from JSON.
   */
  private processSymbolList(symList: JSONSymbol[]) {
    symList.forEach((val, index, arr) => {
      this.systemSymbols.push(
        new SymbolInfo(
          val.name,
          <SymbolType>convertKindtoSymbolType(val.kind),
          val.detail, // detail
          val.documentation, // documentation
          val.sortText // sortText
        )
      );
    });
  }
  // Normalize path of document filename
  private normalizePathtoDoc(document: vscode.TextDocument) {
    return path.normalize(vscode.workspace.asRelativePath(document.fileName));
  }

  private parseSymbolsUsingRegex(
    fileTries: FileTries,
    text: string,
    regex: RegExp,
    callback: {
      (captures: string[]): SymbolInfo | null;
    }
  ) {
    let captures: RegExpExecArray | null;
    while ((captures = regex.exec(text))) {
      let symbolInfo = callback(captures);
      if (!symbolInfo) continue;
      // Set the position we found it as
      symbolInfo.symbolPos = captures.index;
      fileTries.add(symbolInfo);
    }
  }
  getFoldingRanges(document: vscode.TextDocument): vscode.FoldingRange[] {
    let modes = this.getModesForDocument(document);
    if (!modes) return [];
    return modes.getFoldingRanges();
  }
  // Parse and add a document to our list of managed documents
  parseAndAddDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    if (this.tries.has(filename)) {
      return;
    }
    let fileTries = new FileTries();
    this.tries.set(filename, fileTries);
    let modalManager = new ModalManager();
    this.modes.set(filename, modalManager);
    ß;
    // Add system symbols.  ßIn theory we should only do this once, but it takes
    // no appreciable time/memory anyway.
    for (var sym of this.systemSymbols) {
      fileTries.add(sym);
    }
    // Parse out all the symbols
    modalManager.parse(document);
    fileTries.freeze();
  }

  resetDocument(document: vscode.TextDocument) {
    this.removeDocumentInternal(document);
    this.parseAndAddDocument(document);
  }
  removeDocument(document: vscode.TextDocument) {
    this.removeDocumentInternal(document);
  }
  private removeDocumentInternal(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    this.tries.delete(filename);
    this.modes.delete(filename);
  }
  getTriesForDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    return this.tries.get(filename);
  }
  getModesForDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    return this.modes.get(filename);
  }
}
export const DocumentSymbolManager = new DocumentSymbolManagerClass();
