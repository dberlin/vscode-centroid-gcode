import * as vscode from "vscode";
import { DocumentSymbolManager } from "./DocumentManager";

export class CentroidDocumentSymbolProvider
  implements vscode.DocumentSymbolProvider {
  provideDocumentSymbols(
    document: vscode.TextDocument,
    token: vscode.CancellationToken
  ): vscode.ProviderResult<
    vscode.SymbolInformation[] | vscode.DocumentSymbol[]
  > {
    let results: vscode.DocumentSymbol[] = [];
    let modes = DocumentSymbolManager.getModesForDocument(document);
    if (modes) {
      results = results.concat(modes.getDocumentSymbols());
    }
    let subprograms = DocumentSymbolManager.getSubprogramsForDocument(document);
    if (subprograms) {
      results = results.concat(subprograms.getDocumentSymbols());
    }
    return results;
  }
}
