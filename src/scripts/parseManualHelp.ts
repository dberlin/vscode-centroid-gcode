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
import fs from "fs";
import * as js2yaml from "js-yaml";
import { JSDOM } from "jsdom";
if (process.argv.length < 3) {
  console.log("usage: ts-node parseManualHelp <html help files>");
  process.exit(0);
}
for (const fileName of process.argv.slice(2)) {
  const HTMLString = fs.readFileSync(fileName).toString();
  const fileDOM = new JSDOM(HTMLString);
  const fileDOMDoc = fileDOM.window.document;
  const listCollection = fileDOMDoc.getElementsByTagName("li");
  const outputList = [];
  const noteRegEx = /^.*?Note:/;
  // tslint:disable-next-line: prefer-for-of
  for (let i = 0; i < listCollection.length; ++i) {
    const listItem = listCollection[i];
    if (
      !listItem.firstElementChild ||
      listItem.firstElementChild.tagName !== "H3"
    ) {
      continue;
    }
    const originalName = listItem.firstElementChild.textContent;
    if (!originalName) {
      continue;
    }
    const codeSplit = originalName.split(/ - /);
    if (codeSplit.length !== 2) {
      continue;
    }
    const codeNameUnsplit = codeSplit[0].trim();
    const detail = codeSplit[1].trim();
    let documentation = "";
    const kind = codeNameUnsplit.startsWith("M") ? "m-code" : "g-code";
    // tslint:disable-next-line: prefer-for-of
    for (let licIdx = 0; licIdx < listItem.children.length; ++licIdx) {
      const childItem = listItem.children[licIdx];
      switch (childItem.tagName) {
        case "P": {
          if (!childItem.textContent) {
            continue;
          }
          const childText = childItem.textContent;
          let matches;
          // tslint:disable-next-line: no-conditional-assignment
          if ((matches = noteRegEx.exec(childText))) {
            if (!matches.length) {
              continue;
            }

            documentation +=
              "**NOTE:**" + childText.substring(matches[0].length) + "\n\n";
          } else {
            documentation += childText + "\n\n";
          }
          break;
        }
        case "TABLE": {
          // For our help, all rows are TR's
          let firstRow: boolean = true;
          const tableChildren = childItem.children[0].children;
          const cellCount = tableChildren[0].children.length;
          // tslint:disable-next-line: prefer-for-of
          for (let rIdx = 0; rIdx < tableChildren.length; ++rIdx) {
            const tableRow = tableChildren[rIdx];

            let rowStr = "|";
            // tslint:disable-next-line: prefer-for-of
            for (let cIdx = 0; cIdx < tableRow.children.length; ++cIdx) {
              const tableCell = tableRow.children[cIdx];
              rowStr += (tableCell.textContent || "").trim() + "|";
            }
            documentation += rowStr + "\n";
            if (firstRow) {
              firstRow = false;
              rowStr = "|";
              for (let hIdx = 0; hIdx < cellCount; ++hIdx) {
                rowStr += ":---|";
              }
              documentation += rowStr + "\n";
            }
          }
          break;
        }
      }
    }
    outputList.push({
      name: codeNameUnsplit.trim(),
      kind,
      detail,
      documentation,
    });
  }

  console.log(js2yaml.safeDump(outputList, { lineWidth: -1 }));
}
