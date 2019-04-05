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
//
// Note: This example test is leveraging the Mocha test framework.
// Please refer to their documentation on https://mochajs.org/ for help.
//

// The module 'assert' provides assertion methods from node
import * as assert from "assert";
import * as fs from "fs";
import * as path from "path";
// You can import and use all API from the 'vscode' module
// as well as import your extension to test it
import * as vscode from "vscode";
import { DocumentSymbolManagerClass } from "../DocumentManager";
import * as util from "../util";

const testFilePath = path.join(__dirname + "/../../testfiles/");
// Defines a Mocha test suite to group tests of similar kind together
suite("Extension Tests", () => {
  // Defines a Mocha unit test
  test("GCode symbol normalization utility class", () => {
    assert.strictEqual(util.normalizeSymbolName("T1"), "T01");
    assert.strictEqual(util.normalizeSymbolName("t1"), "T01");
    assert.strictEqual(util.normalizeSymbolName("T01"), "T01");
    assert.strictEqual(util.normalizeSymbolName("t01"), "T01");
    assert.strictEqual(util.normalizeSymbolName(" T1 "), "T01");
    assert.strictEqual(util.normalizeSymbolName(" t1 "), "T01");
    assert.strictEqual(util.normalizeSymbolName(" T01 "), "T01");
    assert.strictEqual(util.normalizeSymbolName(" t01 "), "T01");
  });
  let DocumentSymbolManager: DocumentSymbolManagerClass;

  test("GCode parsing", async () => {
    DocumentSymbolManager = new DocumentSymbolManagerClass();

    for (const fileName of fs.readdirSync(testFilePath)) {
      const textDocument = await vscode.workspace.openTextDocument(
        path.join(testFilePath + fileName),
      );
      DocumentSymbolManager.parseAndAddDocument(textDocument);
      const fileTries = DocumentSymbolManager.getTriesForDocument(textDocument);
      assert.notStrictEqual(
        fileTries,
        undefined,
        "the file trie should have been filled in",
      );
      const completions = fileTries.getAllCompletions("");
      assert.ok(
        completions.length >= 0,
        "Didn't find any symbols in the document",
      );
    }
  }).timeout(20000);
});
