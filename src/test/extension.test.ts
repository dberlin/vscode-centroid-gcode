//
// Note: This example test is leveraging the Mocha test framework.
// Please refer to their documentation on https://mochajs.org/ for help.
//

// The module 'assert' provides assertion methods from node
import * as assert from "assert";

// You can import and use all API from the 'vscode' module
// as well as import your extension to test it
import * as vscode from "vscode";
import * as extension from "../extension";
import * as util from "../util";
import { FileTries, DocumentSymbolManager } from "../DocumentManager";

// Defines a Mocha test suite to group tests of similar kind together
suite("Extension Tests", () => {
  // Defines a Mocha unit test
  test("GCode symbol normalization utility class", () => {
    assert.equal(util.normalizeSymbolName("T1"), "T01");
    assert.equal(util.normalizeSymbolName("t1"), "T01");
    assert.equal(util.normalizeSymbolName("T01"), "T01");
    assert.equal(util.normalizeSymbolName("t01"), "T01");
    assert.equal(util.normalizeSymbolName(" T1 "), "T01");
    assert.equal(util.normalizeSymbolName(" t1 "), "T01");
    assert.equal(util.normalizeSymbolName(" T01 "), "T01");
    assert.equal(util.normalizeSymbolName(" t01 "), "T01");
  });
});
