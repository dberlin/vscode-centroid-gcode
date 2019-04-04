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

import { ANTLRInputStream, CharStreams, CommonTokenStream } from "antlr4ts";

import { CentroidGCodeLexer } from "./CentroidGCodeLexer";

import { CentroidGCodeParser } from "./CentroidGCodeParser";

import { PredictionMode } from "antlr4ts/atn/PredictionMode";

// tslint:disable-next-line: max-line-length
export const wordPatternRegExp = /(\#\d*)|(-?\d*\.\d\w*)|([^\`\~\!\@\#\%\^\&\*\(\)\-\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/;

const noLeadingZeroRegEx = /^[A-Z](\d)$/;
/**
 * Normalize the name of a gcode symbol
 * @param symbolName - symbol to normaize
 */
export function normalizeSymbolName(symbolName: string): string {
  let upperName = symbolName.toUpperCase().trim();
  let matches;
  // Convert all non-leading zero forms (G1, G2) to leading zero forms for symbol name
  // tslint:disable-next-line: no-conditional-assignment
  if ((matches = noLeadingZeroRegEx.exec(upperName))) {
    const num = parseInt(matches[1], 10);
    upperName = `${upperName[0]}0${num}`;
  }
  return upperName;
}

/**
 * Return a regular expression that matches any of the input regular expressions
 * @param args - Regular expressions to combine
 */
export function RegExpAny(...args: RegExp[]) {
  const components: string[] = [];
  const flags = new Map();
  for (const arg of args) {
    components.push(arg.source);
    for (const flag of arg.flags.split("")) {
      flags.set(flag, flag);
    }
  }
  const newFlags = [];
  for (const key of flags.keys()) {
    newFlags.push(key);
  }
  const combined = new RegExp(
    `(?:${components.join(")|(?:")})`,
    newFlags.join(""),
  );
  return combined;
}

/**
 * Generate a regular expression that matches lines that have any single word in the word array.
 *
 * @param wordArray - Array of words
 * @param flags - Flags to use on regexp. Defaults to "mg"
 */
export function getRegexFromWordArray(
  wordArray: string[],
  flags: string = "mg",
) {
  return new RegExp(`(?<=^\\s*)(${wordArray.join("|")})(?=\\s*$)`, flags);
}

export function createGCodeLexerForText(text: string) {
  const inputStream = CharStreams.fromString(text);
  return new CentroidGCodeLexer(inputStream);
}
export function createGCodeParserForLexer(lexer: CentroidGCodeLexer) {
  const tokenStream = new CommonTokenStream(lexer);
  const parser = new CentroidGCodeParser(tokenStream);
  parser.interpreter.setPredictionMode(PredictionMode.SLL);
  return parser;
}
export function createGCodeParserForText(text: string) {
  const lexer = createGCodeLexerForText(text);
  return createGCodeParserForLexer(lexer);
}
