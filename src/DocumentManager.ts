"use strict";
import * as path from "path";
import { Trie } from "tiny-trie";
import * as vscode from "vscode";
import help_text from "./json/help_text.json";
import machine_parameters from "./json/machine_parameters.json";
import macro_variables from "./json/macro_variables.json";
import { SymbolInfo, SymbolType } from "./SymbolInfo";

const noLeadingZeroRegEx = new RegExp("^[A-Z]([0-9])$");
function normalizeSymbolName(symbolName: string): string {
  let upperName = symbolName.toUpperCase();
  let matches;
  // Convert all non-leading zero forms (G1, G2) to leading zero forms for symbol name
  if ((matches = noLeadingZeroRegEx.exec(upperName))) {
    let number = parseInt(matches[1]);
    upperName = upperName[0] + "0" + number.toString();
  }
  return upperName;
}

class FileTries {
  private allSymbols: Trie = new Trie();
  private symbolMap: Map<string, SymbolInfo> = new Map();

  getAllCompletions(label: string): SymbolInfo[] {
    let wordResults: string[] = <string[]>(
      this.allSymbols.search(normalizeSymbolName(label), { prefix: true })
    );
    let results: SymbolInfo[] = [];
    wordResults.forEach((val, index, arr) => {
      let sym = this.getSymbol(val);
      if (sym) results.push(sym);
    });
    return results;
  }
  /**
   * Test whether we have any information about a named symbol.
   *
   * @param label - Symbol name to look for.
   * @returns Whether the symbol was found.  This will be true if we processed the symbol, even
   * if various forms of lookups may not find it due to type not matching, etc.
   */
  contains(label: string): boolean {
    return this.allSymbols.test(normalizeSymbolName(label));
  }

  /**
   * Add a symbol to the symbol tries.
   *
   * This function takes care of adding the symbol to the relevant tries.
   * @param symbolInfo - Symbol to add to tries.
   */
  add(symbolInfo: SymbolInfo) {
    let name = normalizeSymbolName(symbolInfo.label);

    this.allSymbols.insert(name);
    this.symbolMap.set(name, symbolInfo);
  }

  /**
   * Return information about a named symbol.
   *
   * @param label - Symbol name to look for.
   * @returns The found symbol or null.
   */
  getSymbol(label: string): SymbolInfo | null {
    let res = this.symbolMap.get(normalizeSymbolName(label));
    return !res ? null : res;
  }

  /**
   * Freeze all the tries so no more insertion can take place,
   * and convert them into DAWGs
   */
  freeze() {
    this.allSymbols.freeze();
  }
}

function convertKindtoSymbolType(kind: string) {
  switch (kind) {
    case "g-code":
      return SymbolType.GCode;
    case "m-code":
      return SymbolType.MCode;
  }
  return SymbolType.OtherCode;
}
class DocumentSymbolManagerClass {
  private tries: Map<string, FileTries> = new Map<string, FileTries>();
  private systemSymbols: SymbolInfo[] = [];
  init(context: vscode.ExtensionContext) {
    this.processSymbolList(help_text);
    this.processSymbolList(machine_parameters);
    this.processSymbolList(<any>macro_variables);
  }
  private processSymbolList(
    symList: {
      kind: string;
      detail: string;
      documentation: string;
      sortText: string;
      name: string;
    }[]
  ) {
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
  // Parse and add a document to our list of managed documents
  parseAndAddDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    if (this.tries.has(filename)) {
      return;
    }
    let fileTries = new FileTries();
    this.tries.set(filename, fileTries);
    // Add system symbols
    // In theory we should only do this once, but it takes no appreciable time/memory anyway
    for (var sym of this.systemSymbols) {
      fileTries.add(sym);
    }
    // Parse out all the symbols
    let docText = document.getText();
    /*
    this.parseSymbolsUsingRegex(
      fileTries,
      docText,
      typedVariableWithComment,
      this.getSymbolInfoFromTypedVariable
    );
    this.parseSymbolsUsingRegex(
      fileTries,
      docText,
      constantVariableWithComment,
      this.getSymbolInfoFromConstantVariable
    );*/
    fileTries.freeze();
  }
  /**
   * Convert a capture array into a typed variable symbol.
   *
   * The current format of the capture array is an internal detail.
   * @remarks This handles the X IS <type> style of variable
   * @param captures - An array of captured strings from micromatch.
   * @returns Newly created symbol info, or null if we could not create symbol info.
   */
  private getSymbolInfoFromTypedVariable(captures: Array<string>) {
    /* // Ignore system variables here, we process them separately
    if (isSystemSymbolName(captures[1])) return null;

    let symbolType = getSymbolTypeFromString(captures[3]);
    if (!symbolType) return null;

    let possibleComment = !captures[5] ? "" : captures[5].trim();
    let symbolDoc = isComment(possibleComment)
      ? formatDocComment(possibleComment)
      : "";
    return new SymbolInfo(
      captures[1],
      symbolType,
      captures[2],
      parseInt(captures[4]),
      0,
      symbolDoc
    );
    */
  }

  /**
   * Convert a capture array into a constant symbol.
   *
   * The current format of the capture array is an internal detail.
   * @remarks This handles the X IS <value> style of variable
   * @param captures - An array of captured strings from micromatch.
   * @returns Newly created symbol info, or null if we could not create symbol info.
   */
  private getSymbolInfoFromConstantVariable(captures: Array<string>) {
    /*// Ignore system variables here, we process them separately
    if (isSystemSymbolName(captures[1])) return null;

    let symbolType = SymbolType.MessageOrConstant;
    let possibleComment = !captures[3] ? "" : captures[3].trim();
    let symbolDoc = isComment(possibleComment)
      ? formatDocComment(possibleComment)
      : "";
    return new SymbolInfo(
      captures[1],
      symbolType,
      captures[2],
      0,
      parseInt(captures[2]),
      symbolDoc
    );*/
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
  }
  getTriesForDocument(document: vscode.TextDocument) {
    let filename = this.normalizePathtoDoc(document);
    return this.tries.get(filename);
  }
}
export const DocumentSymbolManager = new DocumentSymbolManagerClass();
