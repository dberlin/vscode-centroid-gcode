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
import { Token, CommonTokenStream } from "antlr4ts";
import { ParseTreeListener } from "antlr4ts/tree/ParseTreeListener";
import { ParseTreeWalker } from "antlr4ts/tree/ParseTreeWalker";
import * as vscode from "vscode";
import { CentroidGCodeListener } from "./CentroidGCodeListener";
import {
  CentroidGCodeParser,
  OBlockContext,
  ProgramContext
} from "./CentroidGCodeParser";
import { createGCodeParserForText } from "./util";
import { CentroidGCodeLexer } from "./CentroidGCodeLexer";

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
  async parse() {
    let finder = new StageAndModeFinder(this.docSymbols);
    this.parser.removeParseListeners();
    this.parser.addParseListener(finder as ParseTreeListener);
    try {
      let tree = this.parser.program();
      //ParseTreeWalker.DEFAULT.walk(finder as ParseTreeListener, tree);
    } catch (err) {
      console.error(err);
    }
  }
  getDocSymbols() {
    return this.docSymbols;
  }
}
class StageAndModeFinder implements CentroidGCodeListener {
  private regionList: vscode.DocumentSymbol[] = [];
  private docSymbols: vscode.DocumentSymbol[];
  constructor(docSymbols: vscode.DocumentSymbol[]) {
    this.docSymbols = docSymbols;
  }
  private createEmptyRegion(name: string) {
    return new vscode.DocumentSymbol(
      name,
      "",
      vscode.SymbolKind.Function,
      new vscode.Range(0, 0, 1, 1),
      new vscode.Range(0, 0, 1, 1)
    );
  }
  enterProgram(ctx: ProgramContext) {
    let sym = this.createEmptyRegion("Whole Program");
    this.regionList.push(sym);
    this.docSymbols.push(sym);
  }
  exitProgram(ctx: ProgramContext) {
    let startToken = ctx.start;
    let stopToken = ctx.stop as Token;
    this.regionList[0].range = new vscode.Range(
      startToken.line,
      startToken.charPositionInLine,
      stopToken.line,
      stopToken.charPositionInLine
    );
    let sym = this.regionList.pop() as vscode.DocumentSymbol;
  }
  enterOBlock(ctx: OBlockContext) {
    let sym = this.createEmptyRegion(" ");
    if (this.regionList.length != 0)
      this.regionList[this.regionList.length - 1].children.push(sym);
    this.regionList.push(sym);
  }
  exitOBlock(ctx: OBlockContext) {
    let startToken = ctx.start;
    let stopToken = ctx.stop as Token;
    let fullRange = new vscode.Range(
      startToken.line,
      startToken.charPositionInLine,
      stopToken.line,
      stopToken.charPositionInLine
    );
    let nameToken = ctx.O_BLOCK_NUMBER().symbol;
    let nameRange = new vscode.Range(
      nameToken.line,
      nameToken.charPositionInLine,
      nameToken.line,
      nameToken.stopIndex - nameToken.startIndex
    );
    let blockName = ctx.O_BLOCK_NUMBER().text;
    let region = this.regionList.pop() as vscode.DocumentSymbol;
    region.name = blockName;
    region.range = fullRange;
    region.selectionRange = nameRange;
  }
}
