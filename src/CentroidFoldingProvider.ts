import * as vscode from "vscode";
import { DocumentSymbolManager } from "./DocumentManager";
export class CentroidFoldingProvider implements vscode.FoldingRangeProvider {
  provideFoldingRanges(
    document: vscode.TextDocument,
    _context: vscode.FoldingContext,
    _token: vscode.CancellationToken
  ): vscode.ProviderResult<vscode.FoldingRange[]> {
    return DocumentSymbolManager.getFoldingRanges(document);
  }
}
