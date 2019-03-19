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

let testFilePath = path.join(__dirname + "/../../testfiles/");
// Defines a Mocha test suite to group tests of similar kind together
suite("Extension Tests", function() {
  // Defines a Mocha unit test
  test("GCode symbol normalization utility class", function() {
    assert.equal(util.normalizeSymbolName("T1"), "T01");
    assert.equal(util.normalizeSymbolName("t1"), "T01");
    assert.equal(util.normalizeSymbolName("T01"), "T01");
    assert.equal(util.normalizeSymbolName("t01"), "T01");
    assert.equal(util.normalizeSymbolName(" T1 "), "T01");
    assert.equal(util.normalizeSymbolName(" t1 "), "T01");
    assert.equal(util.normalizeSymbolName(" T01 "), "T01");
    assert.equal(util.normalizeSymbolName(" t01 "), "T01");
  });
  let DocumentSymbolManager: DocumentSymbolManagerClass;

  test("GCode parsing", async function() {
    DocumentSymbolManager = new DocumentSymbolManagerClass();

    for (let fileName of fs.readdirSync(testFilePath)) {
      const textDocument = await vscode.workspace.openTextDocument(
        path.join(testFilePath + fileName)
      );
      DocumentSymbolManager.parseAndAddDocument(textDocument);
      let fileTries = DocumentSymbolManager.getTriesForDocument(textDocument);
      assert.notEqual(
        fileTries,
        undefined,
        "the file trie should have been filled in"
      );
      let completions = fileTries.getAllCompletions("");
      assert.ok(
        completions.length >= 0,
        "Didn't find any symbols in the document"
      );
      let modes = DocumentSymbolManager.getModesForDocument(textDocument);
      assert.notEqual(
        modes,
        undefined,
        "the mode info should have been filled in"
      );
    }
  }).timeout(10000);
});
