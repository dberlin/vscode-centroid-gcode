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
import { CommonTokenStream, Token } from "antlr4ts";
import { ParseTreeListener } from "antlr4ts/tree/ParseTreeListener";
import { ParseTreeWalker } from "antlr4ts/tree/ParseTreeWalker";
import * as vscode from "vscode";
import { CentroidGCodeLexer } from "./CentroidGCodeLexer";
import { CentroidGCodeParser } from "./CentroidGCodeParser";
import { StageAndModeFinder } from "./StageAndModeFinder";
import { createGCodeParserForText } from "./util";

export class SymbolManager {
  private document: vscode.TextDocument;
  private parser: CentroidGCodeParser;
  private docSymbols: vscode.DocumentSymbol[];

  constructor(document: vscode.TextDocument) {
    this.document = document;
    this.parser = createGCodeParserForText(document.getText());
    this.parser.buildParseTree = false;
    this.docSymbols = [];
  }
  public async parse() {
    const finder = new StageAndModeFinder(this.docSymbols);
    this.parser.removeParseListeners();
    this.parser.addParseListener(finder as ParseTreeListener);
    try {
      const tree = this.parser.program();
      // ParseTreeWalker.DEFAULT.walk(finder as ParseTreeListener, tree);
    } catch (err) {
      console.error(err);
    }
  }
  public getDocSymbols() {
    return this.docSymbols;
  }
}
