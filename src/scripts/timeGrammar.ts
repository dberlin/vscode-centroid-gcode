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
import {
  ANTLRInputStream,
  BailErrorStrategy,
  CommonTokenStream
} from "antlr4ts";
import { PredictionMode } from "antlr4ts/atn/PredictionMode";
import * as fs from "fs";
import * as path from "path";
import { CentroidGCodeLexer } from "../CentroidGCodeLexer";
import { CentroidGCodeParser } from "../CentroidGCodeParser";
import { createGCodeParserForText, createGCodeLexerForText } from "../util";
if (process.argv.length < 3) {
  console.log("usage: ts-node timeGrammar.ts <directorye>");
  process.exit();
}

let testFilePath =
  process.argv[2] ||
  "/Users/dannyb/Dropbox/sources/vscode/centroid-gcode-language/testfiles/";
// Create the lexer and parser
let lexer;
let parser;
let fileNames;
if (fs.lstatSync(testFilePath).isDirectory()) {
  fileNames = fs
    .readdirSync(testFilePath)
    .map(name => path.join(`${testFilePath}/${name}`));
} else {
  fileNames = [process.argv[2]];
}
for (let fileName of fileNames) {
  console.log(`Processing ${fileName}`);
  const docText = fs.readFileSync(fileName).toString();
  console.time("Lexing");
  lexer = createGCodeLexerForText(docText);
  lexer.getAllTokens();
  console.timeEnd("Lexing");

  parser = createGCodeParserForText(docText);
  console.time("Parsing");
  parser.buildParseTree = false;
  parser.program();

  console.timeEnd("Parsing");
}
