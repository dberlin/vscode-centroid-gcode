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
    return symbolResults;
  }
}
