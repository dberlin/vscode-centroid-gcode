"use strict";
import * as vscode from "vscode";
import { getWordForPosition } from "./util";

/**
 * Handles finding occurrences of symbols in the document.
 *
 * @remarks Currently uses regular expressions, not real knowledge.
 */
export class CentroidReferenceProvider implements vscode.ReferenceProvider {
  provideReferences(
    document: vscode.TextDocument,
    position: vscode.Position,
    context: vscode.ReferenceContext,
    token: vscode.CancellationToken
  ): vscode.ProviderResult<vscode.Location[]> {
    // This may take a while so use a promise.
    return new Promise(resolve => {
      // We use a simple regex to find the occurrences for now
      let wordToLookFor = getWordForPosition(document, position);
      if (!wordToLookFor) {
        resolve([]);
        return;
      }
      let docText = document.getText();
      let regexToUse = RegExp("\\b".concat(wordToLookFor, "\\b"), "g");
      let locationResults: vscode.Location[] = [];
      while (regexToUse.exec(docText) != null) {
        let resultPosition = document.positionAt(regexToUse.lastIndex);
        locationResults.push(new vscode.Location(document.uri, resultPosition));
      }
      resolve(locationResults);
    });
  }
}
