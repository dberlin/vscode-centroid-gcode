"use strict";
import * as vscode from "vscode";
import { FileTries } from "./FileTries";
import help_text from "./json/help_text.json";
import machine_parameters from "./json/machine_parameters.json";
import macro_variables from "./json/macro_variables.json";
import { ModalManager } from "./ModalManager";
import { SymbolInfo, SymbolType } from "./SymbolInfo";
import { BaseDocumentSymbolManagerClass } from "./vscode-centroid-common/BaseDocumentManager";

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
class DocumentSymbolManagerClass extends BaseDocumentSymbolManagerClass {
  private modes: Map<string, ModalManager> = new Map<string, ModalManager>();

  init(context: vscode.ExtensionContext) {
    this.processSymbolList(help_text);
    this.processSymbolList(machine_parameters);
    this.processSymbolList(<any>macro_variables);
    super.init(context);
  }

  /**
   * Take a list of JSOn symbols and convert them to VSCode SymbolInfo.
   *
   * @param symList - list of symbols from JSON.
   */
  protected processSymbolList(symList: JSONSymbol[]) {
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

  getFoldingRanges(document: vscode.TextDocument): vscode.FoldingRange[] {
    let modes = this.getModesForDocument(document);
    if (!modes) return [];
    return modes.getFoldingRanges();
  }
  // Parse and add a document to our list of managed documents
  parseAndAddDocument(document: vscode.TextDocument) {
    if (this.hasDocument(document)) return;

    let filename = this.normalizePathtoDoc(document);
    let fileTries: FileTries = new FileTries();
    this.tries.set(filename, fileTries);

    let modalManager = new ModalManager();
    this.modes.set(filename, modalManager);

    super.parseAndAddDocument(document);

    // Parse out all the symbols
    modalManager.parse(document);
    fileTries.freeze();
  }

  protected removeDocumentInternal(document: vscode.TextDocument) {
    super.removeDocumentInternal(document);
    let filename = this.normalizePathtoDoc(document);
    this.modes.delete(filename);
  }
  getModesForDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    return this.modes.get(filename);
  }
  getTriesForDocument(document: vscode.TextDocument) {
    return super.getTriesForDocument(document) as FileTries;
  }
}
export const DocumentSymbolManager = new DocumentSymbolManagerClass();
