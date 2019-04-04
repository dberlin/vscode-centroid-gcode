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
const machineParameters = JSON.parse(
  fs.readFileSync("machine_parameters.json").toString(),
);
const outputList = [];
for (const param of machineParameters) {
  // Grab the last 3 numbers as an integer
  const paramNum = parseInt(
    param.name
      .split("")
      .reverse()
      .slice(0, 3)
      .reverse()
      .join(""),
    10,
  );
  // Only parameters 0-399 and 900-999 are accessible from G-Code.
  if (paramNum > 399 && paramNum < 900) {
    continue;
  }
  outputList.push({
    name: `#${9000 + paramNum}`,
    detail: `"Machine parameter ${paramNum}`,
    documentation: param.documentation,
    kind: param.kind,
    sortText: `${9000 + paramNum}`.padStart(5, "0"),
  });
}
console.log(JSON.stringify(outputList, null, 2));
