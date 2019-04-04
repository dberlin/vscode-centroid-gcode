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
"use strict";
import * as vscode from "vscode";
import { BaseSymbolInfo } from "./vscode-centroid-common/BaseSymbolInfo";

export enum SymbolType {
  GCode,
  MCode,
  Label,
  OtherCode,
  SystemVariable,
}
export class SymbolInfo extends BaseSymbolInfo {
  /* What kind of symbol is it. */
  public symbolType: SymbolType;
  constructor(
    name: string,
    type: SymbolType,
    detail: string,
    doc: string = "",
    sortText: string = "",
    value: number = 0,
    pos: number = -1,
  ) {
    const kind =
      type === SymbolType.SystemVariable
        ? vscode.CompletionItemKind.Variable
        : vscode.CompletionItemKind.Operator;

    super(name, kind, doc, detail, sortText, value, pos);

    this.symbolType = type;
  }
}
