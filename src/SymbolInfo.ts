"use strict";
import * as vscode from "vscode";

export enum SymbolType {
  GCode,
  MCode,
  Label,
  OtherCode,
  SystemVariable
}
export class SymbolInfo extends BaseSymbolInfo {
  /* What kind of symbol is it. */
  symbolType: SymbolType;
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

    super(name, kind, doc, detail, sortText, value, pos);

    this.symbolType = type;
  }
}
