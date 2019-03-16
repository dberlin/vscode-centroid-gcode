"use strict";
import * as vscode from "vscode";
import { getSymbolForPosition } from "./util";

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
      if (sym.symbolPos != -1) {
        let symbolPos = document.positionAt(sym.symbolPos);
        /* Don't produce a hover for the same position we declared the symbol on */
        if (position.line === symbolPos.line) return null;
      }
      if ((<vscode.MarkdownString>sym.documentation).value.startsWith("\n\n")) {
        hoverText.appendMarkdown("#### " + (sym.detail || "").trim());
      }
      hoverText.appendMarkdown(
        (<vscode.MarkdownString>sym.documentation).value
      );
      let hover = new vscode.Hover(hoverText);
      return hover;
    }
  }
}
