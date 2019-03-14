"use strict";
import * as vscode from "vscode";

export enum SymbolType {
  GCode,
  MCode,
  Label,
  OtherCode,
  SystemVariable
}
export class SymbolInfo extends vscode.CompletionItem {
  /* If this is a constant symbol, what is the value. */
  symbolValue: number;
  /* What kind of symbol is it. */
  symbolType: SymbolType;
  /* What offset in the file did the symbol appear at. */
  symbolPos: number;

  constructor(
    name: string,
    type: SymbolType,
    detail: string,
    doc: string = "",
    sortText: string = "",
    value: number = 0,
    pos: number = -1
  ) {
    let kind =
      type == SymbolType.SystemVariable
        ? vscode.CompletionItemKind.Variable
        : vscode.CompletionItemKind.Operator;
    super(name, kind);
    this.documentation = new vscode.MarkdownString(doc);
    this.detail = detail;
    this.symbolType = type;
    this.symbolValue = value;
    this.symbolPos = pos;
    this.sortText = sortText;
  }
}
