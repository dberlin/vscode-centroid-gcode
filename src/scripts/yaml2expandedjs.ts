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
import js2yaml from "js-yaml";
const fileData = js2yaml.safeLoad(fs.readFileSync(process.argv[2]).toString());
const outputList = [];
// Perform name expansion and sort order generation
const numericRegexp = /[GM](\d+)/i;
for (const item of fileData) {
  for (const codeName of item.name.split(/, /)) {
    const namePieces = numericRegexp.exec(codeName);
    if (!namePieces) {
      continue;
    }
    const nameVal = parseInt(namePieces[1], 10);
    const sortVal = `#${codeName[0]}${nameVal.toString().padStart(4, "0")}`;
    outputList.push({
      name: codeName.trim(),
      kind: item.kind,
      detail: item.detail,
      documentation: item.documentation,
      sortText: sortVal,
    });
  }
}
console.log(JSON.stringify(outputList, null, 2));
