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
import { JSDOM } from "jsdom";
import fs from "fs";
function range(a: number, b: number, step?: number): number[] {
  let result = [];
  step = step || 1;
  for (let i = a; (b - i) * step > 0; i += step) result.push(i);
  return result;
}
let tupleRangeRegex = /\((\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/;
function tupleRange(str: string) {
  let matches;
  if ((matches = tupleRangeRegex.exec(str))) {
    return range(
      parseInt(matches[1]),
      parseInt(matches[2]) + 1,
      parseInt(matches[3])
    );
  }
  return null;
}
let regularRangeRegex = /(\d+)\s*-\s*(\d+)/;
function regularRange(str: string) {
  let matches;
  if ((matches = regularRangeRegex.exec(str))) {
    let lower = parseInt(matches[1]);
    let upper = parseInt(matches[2]) + 1;
    return range(lower, upper, 1);
  }
  return [parseInt(str)];
}
if (process.argv.length < 3) {
  console.log("usage: ts-node parseManualHelp <html help files>");
  process.exit(0);
}
for (let fileName of process.argv.slice(2)) {
  let HTMLString = fs.readFileSync(fileName).toString();
  let fileDOM = new JSDOM(HTMLString);
  let fileDOMDoc = fileDOM.window.document;
  let tableCollection = fileDOMDoc.getElementsByTagName("table");
  let outputList = [];
  let tableArray = [];
  let noteRegEx = /^.*?Note:/;
  for (let i = 0; i < tableCollection.length; ++i) {
    let tableItem = tableCollection[i];

    let documentation = "";
    // For our help, all rows are TR's
    let tableChildren = tableItem.children[0].children;
    for (let rIdx = 0; rIdx < tableChildren.length; ++rIdx) {
      let tableRow = tableChildren[rIdx];
      let rowArray = [];
      for (let cIdx = 0; cIdx < tableRow.children.length; ++cIdx) {
        let tableCell = tableRow.children[cIdx];
        rowArray.push((<string>tableCell.textContent).trim());
      }
      tableArray.push(rowArray);
    }
  }
  let tupleRangeRegex = /\((\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/;

  for (const arrayRow of tableArray) {
    let rowRange = tupleRange(arrayRow[0]) || regularRange(arrayRow[0]);
    let num = 1;
    for (let idx of rowRange) {
      let indexRegex = /\$i/;
      let replacedRow1 = arrayRow[1].replace(indexRegex, num.toString());
      let name = `#${idx}`;
      let kind = "system-variable";
      let detail = replacedRow1.trim();
      let documentation = "";
      if (arrayRow.length > 3) {
        let replacedRow2 = arrayRow[2].replace(indexRegex, num.toString());
        documentation = replacedRow2.trim();
        if (arrayRow[3].trim() === "R/W") {
          documentation += "\n\nThis variable is read/write";
        } else if (arrayRow[3].trim() === "R") {
          documentation += "\n\nThis variable is read-only";
        }
      } else {
        if (arrayRow[2].trim() === "R/W") {
          documentation += "\n\nThis variable is read/write";
        } else if (arrayRow[2].trim() === "R") {
          documentation += "\n\nThis variable is read-only";
        }
      }
      ++num;
      outputList.push({
        name: name,
        kind: kind,
        detail: detail,
        documentation: documentation,
        sortText: `${idx}`.padStart(5, "0")
      });
    }
  }

  console.log(JSON.stringify(outputList, null, 2));
}
