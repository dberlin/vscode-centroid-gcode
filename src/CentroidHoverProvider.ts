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
"use strict";
import * as vscode from "vscode";
import { getSymbolForPosition } from "./vscode-util";
import { DocumentSymbolManager } from "./DocumentManager";

function getMacroParameterNum(name: string): number {
  if (!name.startsWith("#")) return 0;
  let result = parseInt(name.substr(1));
  if (result) return result;
  return 0;
}

export class CentroidHoverProvider implements vscode.HoverProvider {
  public provideHover(
    document: vscode.TextDocument,
    position: vscode.Position,
    token: vscode.CancellationToken
  ): vscode.ProviderResult<vscode.Hover> {
    /* See if we have the symbol */
    let sym = getSymbolForPosition(document, position);
    if (sym) {
      let hoverText = new vscode.MarkdownString();
      if (sym.symbolDeclPos != -1) {
        let symbolDeclPos = document.positionAt(sym.symbolDeclPos);
        /* Don't produce a hover for the same position we declared the symbol on */
        if (position.line === symbolDeclPos.line) return null;
      }
      // If it is a macro parameter not in the system range, format the detail part.
      hoverText.appendMarkdown(`#### ${(sym.detail || "").trim()}\n\n`);

      hoverText.appendMarkdown(
        (<vscode.MarkdownString>sym.documentation).value
      );
      return new vscode.Hover(hoverText);
    }
    /*
    // Provide the active gcode modes if the code is branch free
    let subPrograms = DocumentSymbolManager.getSubprogramsForDocument(document);
    if (subPrograms && !subPrograms.isBranchFree()) return null;
    let modeData = DocumentSymbolManager.getModesForDocument(document);
    if (modeData) {
      let activeModes = modeData
        .getActiveModes(document.offsetAt(position))
        .sort();
      if (activeModes && activeModes.length > 0) {
        let hoverText = new vscode.MarkdownString("### Active GCode modes\n\n");
        for (let modeString of activeModes) {
          hoverText.appendMarkdown("**" + modeString + "**\n");
        }
        return new vscode.Hover(hoverText);
      }
    }*/
    return null;
  }
}
