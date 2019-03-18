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
    let modes = DocumentSymbolManager.getModesForDocument(document);
    if (!modes) return null;
    return modes.getDocumentSymbols();
  }
}
