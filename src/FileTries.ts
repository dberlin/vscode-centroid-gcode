import { SymbolInfo } from "./SymbolInfo";
import { BaseFileTries } from "./vscode-centroid-common/BaseFileTries";
export class FileTries extends BaseFileTries {
  getSymbol(label: string): SymbolInfo | null {
    return super.getSymbol(label) as SymbolInfo | null;
  }
}
