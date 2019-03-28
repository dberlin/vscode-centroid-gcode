/*
 * MIT License
 *
 * Copyright (c) 2019 Daniel Berlin
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import * as vscode from "vscode";
import { FileTries } from "./FileTries";
import help_text from "./json/help_text.json";
import machine_parameters from "./json/machine_parameters.json";
import macro_variables from "./json/macro_variables.json";
import { SymbolInfo, SymbolType } from "./SymbolInfo";
import { SymbolManager } from "./SymbolManager";
import { BaseDocumentSymbolManagerClass } from "./vscode-centroid-common/BaseDocumentManager";
"use strict";

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
export class DocumentSymbolManagerClass extends BaseDocumentSymbolManagerClass {
  private symbolManager = new Map<string, SymbolManager>();
  constructor() {
    super();
    this.processSymbolList(help_text);
    this.processSymbolList(machine_parameters);
    this.processSymbolList(<any>macro_variables);
  }

  /**
   * Take a list of JSOn symbols and convert them to VSCode SymbolInfo.
   *
   * @param symList - list of symbols from JSON.
   */
  protected processSymbolList(symList: JSONSymbol[]) {
    symList.forEach(val => {
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
    /*
    let modes = this.getModesForDocument(document);
    if (!modes) return [];
    return modes.getFoldingRanges();*/
    return [];
  }
  // Parse and add a document to our list of managed documents
  async parseAndAddDocument(document: vscode.TextDocument) {
    if (this.hasDocument(document)) return;

    let filename = this.normalizePathtoDoc(document);
    let fileTries: FileTries = new FileTries();
    this.tries.set(filename, fileTries);
    let symbolManager = new SymbolManager(document);
    this.symbolManager.set(filename, symbolManager);
    super.parseAndAddDocument(document);

    symbolManager.parse();
    fileTries.freeze();
  }

  protected removeDocumentInternal(document: vscode.TextDocument) {
    super.removeDocumentInternal(document);
    let filename = this.normalizePathtoDoc(document);
    this.symbolManager.delete(filename);
  }

  getTriesForDocument(document: vscode.TextDocument) {
    return super.getTriesForDocument(document) as FileTries;
  }

  getDocumentSymbolsForDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    let symbolManager = this.symbolManager.get(filename);
    if (symbolManager) return symbolManager.getDocSymbols();
    return [];
  }
}
export const DocumentSymbolManager = new DocumentSymbolManagerClass();
