import * as js2yaml from "js-yaml";
import { JSDOM } from "jsdom";
import fs from "fs";
if (process.argv.length < 3) {
  console.log("usage: ts-node parseManualHelp <html help files>");
  process.exit(0);
}
for (let fileName of process.argv.slice(2)) {
  let HTMLString = fs.readFileSync(fileName).toString();
  let fileDOM = new JSDOM(HTMLString);
  let fileDOMDoc = fileDOM.window.document;
  let listCollection = fileDOMDoc.getElementsByTagName("li");
  let outputList = [];
  let noteRegEx = new RegExp("^.*?Note:");
  for (let i = 0; i < listCollection.length; ++i) {
    const listItem = listCollection[i];
    if (
      !listItem.firstElementChild ||
      listItem.firstElementChild.tagName != "H3"
    )
      continue;
    let originalName = listItem.firstElementChild.textContent;
    if (!originalName) continue;
    let codeSplit = originalName.split(new RegExp(" - "));
    if (codeSplit.length != 2) continue;
    let codeNameUnsplit = codeSplit[0].trim();
    let detail = codeSplit[1].trim();
    let documentation = "";
    let kind = codeNameUnsplit.startsWith("M") ? "m-code" : "g-code";
    for (let licIdx = 0; licIdx < listItem.children.length; ++licIdx) {
      let childItem = listItem.children[licIdx];
      switch (childItem.tagName) {
        case "P": {
          if (!childItem.textContent) continue;
          let childText = childItem.textContent;
          let matches;
          if ((matches = noteRegEx.exec(childText))) {
            if (!matches.length) continue;

            documentation +=
              "**NOTE:**" + childText.substring(matches[0].length) + "\n\n";
          } else documentation += childText + "\n\n";
          break;
        }
        case "TABLE": {
          // For our help, all rows are TR's
          let firstRow: boolean = true;
          let tableChildren = childItem.children[0].children;
          let cellCount = tableChildren[0].children.length;
          for (let rIdx = 0; rIdx < tableChildren.length; ++rIdx) {
            let tableRow = tableChildren[rIdx];

            let rowStr = "|";
            for (let cIdx = 0; cIdx < tableRow.children.length; ++cIdx) {
              let tableCell = tableRow.children[cIdx];
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
      kind: kind,
      detail: detail,
      documentation: documentation
    });
  }

  console.log(js2yaml.safeDump(outputList, { lineWidth: -1 }));
}
