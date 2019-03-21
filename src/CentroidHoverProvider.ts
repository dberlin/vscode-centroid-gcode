"use strict";
import * as vscode from "vscode";
import { getSymbolForPosition } from "./util";
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
    // Provide the active gcode modes
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
    }
    return null;
  }
}
