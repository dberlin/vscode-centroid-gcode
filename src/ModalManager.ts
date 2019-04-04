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
import IntervalTree from "node-interval-tree";
import { isString } from "util";
import * as vscode from "vscode";
import { normalizeSymbolName, RegExpAny } from "./util";

function isComment(str: string) {
  return str[0] === ";" || str[0] === ":";
}
// Centroid G-Code modal groups
const GroupA = /G[0]*[0123]/gi;
const GroupC = /G1[789]|G11[789]/gi;
const GroupD = /G4[012]/gi;
const GroupE = /G4[349]|G43.3|G43.4/gi;
const GroupF = /G6[14]/gi;
const GroupG = /G7[346]|G8[0123459]|G17[346]|G18[0123459]/gi;
const GroupH = /G9[01]/gi;
const GroupI = /G9[89]/gi;
const GroupJ = /G65/gi;
const GroupK = /G2[01]/gi;
const GroupL = /G5[456789]/gi;
const GroupM = /G5[01]/gi;
const GroupN = /G6[89]|G68.1/gi;
const GroupO = /G2[23]/gi;
const GroupP = /G9[34]|G93.1/gi;
const MGroupA = /M[0]*[345]/gi;
const TGroupA = /T\d\d?\d?/gi;
const Comments = /;.*$/gim;
const Strings = /"(?:\\["\\]|[^\n"\\])*"/gim;

const ModalRegex = RegExpAny(
  Comments,
  Strings,
  // GroupA,
  GroupC,
  GroupD,
  GroupE,
  GroupF,
  GroupG,
  GroupH,
  GroupI,
  GroupJ,
  GroupK,
  GroupL,
  GroupM,
  GroupN,
  GroupO,
  GroupP,
  MGroupA,
  TGroupA,
);

interface CodeOffset {
  code: string;
  offset: number;
}

export class ModalManager {
  private codeIntervals: IntervalTree<string>;
  private currentRanges: Map<string, CodeOffset[]> = new Map();
  private finalRanges: vscode.FoldingRange[] = [];
  private documentSymbols: vscode.DocumentSymbol[] = [];
  private readonly defaultModes = new Set([
    "G17",
    "G40",
    "G49",
    "G64",
    "G80",
    "G90",
    "G98",
    "G20",
    "G50",
    "G69",
    "G23",
    "M05",
  ]);
  private readonly gcodeToGroupName: Map<string, string>;
  constructor() {
    this.gcodeToGroupName = new Map([
      ["G00", "A"],
      ["G01", "A"],
      ["G02", "A"],
      ["G03", "A"],
      ["G04", "B"],
      ["G09", "B"],
      ["G10", "B"],
      ["G17", "C"],
      ["G18", "C"],
      ["G19", "C"],
      ["G20", "K"],
      ["G21", "K"],
      ["G22", "O"],
      ["G23", "O"],
      ["G28", "B"],
      ["G29", "B"],
      ["G30", "B"],
      ["G40", "D"],
      ["G41", "D"],
      ["G42", "D"],
      ["G43", "E"],
      ["G43.3", "E"],
      ["G43.4", "E"],
      ["G44", "E"],
      ["G49", "E"],
      ["G50", "M"],
      ["G51", "M"],
      ["G52", "B"],
      ["G53", "B"],
      ["G54", "L"],
      ["G55", "L"],
      ["G56", "L"],
      ["G57", "L"],
      ["G58", "L"],
      ["G59", "L"],
      ["G61", "F"],
      ["G64", "F"],
      ["G65", "J"],
      ["G68", "N"],
      ["G68.1", "N"],
      ["G69", "N"],
      ["G73", "G"],
      ["G74", "G"],
      ["G76", "G"],
      ["G80", "G"],
      ["G81", "G"],
      ["G82", "G"],
      ["G83", "G"],
      ["G84", "G"],
      ["G85", "G"],
      ["G89", "G"],
      ["G90", "H"],
      ["G91", "H"],
      ["G92", "B"],
      ["G93", "P"],
      ["G93.1", "P"],
      ["G94", "P"],
      ["G98", "I"],
      ["G99", "I"],
      ["G117", "C"],
      ["G118", "C"],
      ["G119", "C"],
      ["G173", "G"],
      ["G174", "G"],
      ["G176", "G"],
      ["G180", "G"],
      ["G181", "G"],
      ["G182", "G"],
      ["G183", "G"],
      ["G184", "G"],
      ["G185", "G"],
      ["G189", "G"],
      ["M03", "MGroupA"],
      ["M04", "MGroupA"],
      ["M05", "MGroupA"],
    ]);
    for (let i = 0; i <= 200; ++i) {
      this.gcodeToGroupName.set(
        normalizeSymbolName("T" + i.toString()),
        "TGroupA",
      );
    }
    this.codeIntervals = new IntervalTree();
    // Default modes per manual.
    // We aren't bothering with group A right now

    this.currentRanges = new Map([
      ["C", [{ code: "G17", offset: 0 }]],
      ["D", [{ code: "G40", offset: 0 }]],
      ["E", [{ code: "G49", offset: 0 }]],
      ["F", [{ code: "G64", offset: 0 }]],
      ["G", [{ code: "G80", offset: 0 }]],
      ["H", [{ code: "G90", offset: 0 }]],
      ["I", [{ code: "G98", offset: 0 }]],
      ["K", [{ code: "G20", offset: 0 }]],
      ["M", [{ code: "G50", offset: 0 }]],
      ["N", [{ code: "G69", offset: 0 }]],
      ["MGroupA", [{ code: normalizeSymbolName("M5"), offset: 0 }]],
    ]);
  }

  public getGroupNameforGCode(name: string) {
    return this.gcodeToGroupName.get(name);
  }

  public getFoldingRanges() {
    return this.finalRanges;
  }
  /**
   * Get the active GCode modes at a point in the document.
   *
   * @param pos - Byte position in the document.
   */
  public getActiveModes(pos: number): string[] {
    return this.codeIntervals.search(pos, pos);
  }

  public getDocumentSymbols(): vscode.DocumentSymbol[] {
    return this.documentSymbols;
  }

  /**
   * Parse GCode and store the modes.
   * @param textToParse - Text to parse modes out of.
   */
  public parse(document: vscode.TextDocument) {
    const textToParse = document.getText();
    let matches: RegExpExecArray | null;

    // Javascript makes it impossible to discover which capture triggered in
    // less than linear time per match, because it produces empty undefined
    // slots and no capture group index or anything similar, so the entire list
    // of possible capture groups must be walked. Because the set of strings we
    // may capture is small, we just work around this.
    // tslint:disable-next-line: no-conditional-assignment
    while ((matches = ModalRegex.exec(textToParse))) {
      const match = matches[0];
      // Ignore comments and strings
      if (isComment(match) || match[0] === '"') {
        continue;
      }
      const groupName = this.getGroupNameforGCode(normalizeSymbolName(match));
      if (!groupName) {
        console.info(
          "Can't find group name for %s",
          normalizeSymbolName(match),
        );
        continue;
      }
      let currArray = this.currentRanges.get(groupName) as CodeOffset[];
      if (currArray === undefined) {
        currArray = [];
        this.currentRanges.set(groupName, currArray);
      }
      // We look for mode change to mode change.
      currArray.push({
        code: normalizeSymbolName(match),
        offset: matches.index,
      });
      if (currArray.length === 2) {
        const item2 = currArray[1];
        const item1 = currArray.shift() as CodeOffset;
        // If they are the same mode, the mode has not changed.
        // Since we have two items, it means we want to update the
        // start of the new item to the start of the old item.
        if (item1.code === item2.code) {
          item2.offset = item1.offset;
          continue;
        }
        if (this.isDefaultMode(item1.code)) {
          continue;
        }
        if (this.isFoldingGroup(groupName)) {
          const item1Pos = document.positionAt(item1.offset);
          const item2Pos = document.positionAt(item2.offset);
          this.addFoldingRange(item1Pos, item2Pos);
          this.addDocumentSymbol(item1Pos, item2Pos, item1);
        }
        this.codeIntervals.insert(item1.offset, item2.offset, item1.code);
      }
    }

    // At the end of the document, see what modes are left
    const endOffset = textToParse.length;
    for (const entry of this.currentRanges) {
      const item = entry[1].shift() as CodeOffset;
      if (this.isDefaultMode(item.code)) {
        continue;
      }
      if (this.isFoldingGroup(entry[0])) {
        const itemPos = document.positionAt(item.offset);
        const endPos = document.positionAt(endOffset);
        this.addFoldingRange(itemPos, endPos);
        this.addDocumentSymbol(itemPos, endPos, item);
      }
      this.codeIntervals.insert(item.offset, endOffset, item.code);
    }
  }
  private isDefaultMode(mode: string) {
    return this.defaultModes.has(mode);
  }

  private isFoldingGroup(groupName: string) {
    return groupName === "TGroupA";
  }

  private addFoldingRange(itemPos: vscode.Position, endPos: vscode.Position) {
    this.finalRanges.push(
      new vscode.FoldingRange(
        itemPos.line,
        endPos.line - 1,
        vscode.FoldingRangeKind.Region,
      ),
    );
  }
  /**
   *
   * Add a document symbol for a region where a given gcode/etc is active
   *
   * @param beginPos - Position where region begins
   * @param endPos - Position right after where region ends
   * @param activeCode - Item that goes with region
   */
  private addDocumentSymbol(
    beginPos: vscode.Position,
    endPos: vscode.Position,
    activeCode: CodeOffset,
  ) {
    // The end is really where the next match began. Back it up to the previous line

    const toolRegion = new vscode.Range(
      beginPos.with(undefined, 0),
      endPos.with(endPos.line - 1, 0),
    );
    const symbolNameRegion = new vscode.Range(
      beginPos,
      beginPos.with(undefined, beginPos.character + activeCode.code.length),
    );
    if (activeCode.code.startsWith("T")) {
      this.documentSymbols.push(
        new vscode.DocumentSymbol(
          "Tool " + activeCode.code + " region",
          "Region where tool " + activeCode.code + " is active",
          vscode.SymbolKind.Function,
          toolRegion,
          symbolNameRegion,
        ),
      );
    }
  }
}
