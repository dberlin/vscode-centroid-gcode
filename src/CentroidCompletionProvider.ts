"use strict";
import * as vscode from "vscode";
import { DocumentSymbolManager } from "./DocumentManager";
import { getWordForPosition } from "./util";

export class CentroidCompletionProvider
  implements vscode.CompletionItemProvider {
  async provideCompletionItems(
    document: vscode.TextDocument,
    position: vscode.Position,
    token: vscode.CancellationToken,
    context: vscode.CompletionContext
  ): Promise<vscode.CompletionItem[] | vscode.CompletionList> {
    let wordText = getWordForPosition(document, position);
    wordText = !wordText ? "" : wordText;
    let tries = DocumentSymbolManager.getTriesForDocument(document);
    if (!tries) return [];
    let symbolResults = tries.getAllCompletions(wordText);

    // Mark the list as incomplete if > 1000 because of how slow vscode is at handling it
    if (symbolResults.length > 1000) {
      symbolResults.sort((a, b) => {
        if (<string>a.sortText < <string>b.sortText) return -1;
        else if (<string>a.sortText > <string>b.sortText) return 1;
        return 0;
      });
      return new vscode.CompletionList(symbolResults.slice(0, 1000), true);
    }
    return symbolResults;
  }
}
