import { RegExpAny, normalizeSymbolName } from "./util";
import IntervalTree from "node-interval-tree";
import * as vscode from "vscode";

// Centroid G-Code modal groups
let GroupA = /(?<A>G[0]*[0123])/gi;
let GroupC = /(?<C>G1[789]|G11[789])/gi;
let GroupD = /(?<D>G4[012])/gi;
let GroupE = /(?<E>G4[349]|G43.3|G43.4)/gi;
let GroupF = /(?<F>G6[14])/gi;
let GroupG = /(?<G>G7[346]|G8[0123459]|G17[346]|G18[0123459])/gi;
let GroupH = /(?<H>G9[01])/gi;
let GroupI = /(?<I>G9[89])/gi;
let GroupJ = /(?<J>G65)/gi;
let GroupK = /(?<K>G2[01])/gi;
let GroupL = /(?<L>G5[456789])/gi;
let GroupM = /(?<M>G5[01])/gi;
let GroupN = /(?<N>G6[89]|G68.1)/gi;
let GroupP = /(?<P>G9[34]|G93.1)/gi;
let MGroupA = /(?<MCode>M[0]*[345])/gi;

let ModalRegex = RegExpAny(
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
  GroupP,
  MGroupA
);
// Map from group name to index in the range map
const groupNameToIndex = new Map([
  ["C", 1],
  ["D", 2],
  ["E", 3],
  ["F", 4],
  ["G", 5],
  ["H", 6],
  ["I", 7],
  ["J", 8],
  ["K", 9],
  ["L", 10],
  ["M", 11],
  ["N", 12],
  ["P", 13],
  ["MCodeA", 14]
]);

function getIndexForGroupName(name: string) {
  return groupNameToIndex.get(name) || 0;
}

interface CodeOffset {
  code: string;
  offset: number;
}

export class ModalManager {
  private codeIntervals: IntervalTree<string>;
  private currentRanges: Map<number, CodeOffset[]> = new Map();
  private finalRanges: vscode.FoldingRange[] = [];
  private defaultModes = new Set([
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
    "M05"
  ]);

  getFoldingRanges() {
    return this.finalRanges;
  }
  /**
   * Get the active GCode modes at a point in the document.
   *
   * @param pos - Byte position in the document.
   */
  getActiveModes(pos: number): string[] {
    return this.codeIntervals.search(pos, pos);
  }
  private isDefaultMode(mode: string) {
    return this.defaultModes.has(mode);
  }
  /**
   * Parse GCode and store the modes.
   * @param textToParse - Text to parse modes out of.
   */
  parse(document: vscode.TextDocument) {
    let textToParse = document.getText();
    let matches: RegExpExecArray | null;
    while ((matches = ModalRegex.exec(textToParse))) {
      let i = 0;
      // Figure out what mode we matched
      for (let match of matches.slice(1)) {
        ++i;

        if (match === undefined) continue;
        let currArray = <CodeOffset[]>this.currentRanges.get(i);
        if (currArray == undefined) {
          currArray = [];
          this.currentRanges.set(i, currArray);
        }
        // We look for mode change to mode change.
        currArray.push({
          code: normalizeSymbolName(match),
          offset: matches.index
        });
        if (currArray.length === 2) {
          console.log(currArray);
          let item2 = currArray[1];
          let item1 = <CodeOffset>currArray.shift();
          // If they are the same mode, the mode has not changed.
          // Since we have two items, it means we want to update the start of the new item to the start of the old item.
          if (item1.code === item2.code) {
            item2.offset = item1.offset;
            break;
          }
          if (this.isDefaultMode(item1.code)) break;
          if (i === getIndexForGroupName("MCodeA")) {
            this.finalRanges.push(
              new vscode.FoldingRange(
                document.positionAt(item1.offset).line,
                document.positionAt(item2.offset).line,
                vscode.FoldingRangeKind.Region
              )
            );
          }
          this.codeIntervals.insert(item1.offset, item2.offset, item1.code);
        }
        break;
      }
    }
    // At the end of the document, see what modes are left
    let endPos = textToParse.length;
    for (let entry of this.currentRanges) {
      let item = <CodeOffset>entry[1].shift();
      if (this.isDefaultMode(item.code)) continue;
      if (entry[0] === getIndexForGroupName("MCodeA")) {
        this.finalRanges.push(
          new vscode.FoldingRange(
            document.positionAt(item.offset).line,
            document.positionAt(endPos).line,
            vscode.FoldingRangeKind.Region
          )
        );
      }
      this.codeIntervals.insert(item.offset, endPos, item.code);
    }
  }
  constructor() {
    this.codeIntervals = new IntervalTree();
    // Default modes per manual.
    // We aren't bothering with group A right now

    this.currentRanges = new Map([
      [getIndexForGroupName("C"), [{ code: "G17", offset: 0 }]],
      [getIndexForGroupName("D"), [{ code: "G40", offset: 0 }]],
      [getIndexForGroupName("E"), [{ code: "G49", offset: 0 }]],
      [getIndexForGroupName("F"), [{ code: "G64", offset: 0 }]],
      [getIndexForGroupName("G"), [{ code: "G80", offset: 0 }]],
      [getIndexForGroupName("H"), [{ code: "G90", offset: 0 }]],
      [getIndexForGroupName("I"), [{ code: "G98", offset: 0 }]],
      [getIndexForGroupName("K"), [{ code: "G20", offset: 0 }]],
      [getIndexForGroupName("M"), [{ code: "G50", offset: 0 }]],
      [getIndexForGroupName("N"), [{ code: "G69", offset: 0 }]],
      [
        getIndexForGroupName("MCodeA"),
        [{ code: normalizeSymbolName("M5"), offset: 0 }]
      ]
    ]);
  }
}
