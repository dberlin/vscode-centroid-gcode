import * as vscode from "vscode";
import { CentroidGCodeListener } from "./CentroidGCodeListener";
import { OBlockContext, ProgramContext } from "./CentroidGCodeParser";
export class StageAndModeFinder implements CentroidGCodeListener {
  private regionList: vscode.DocumentSymbol[] = [];
  private docSymbols: vscode.DocumentSymbol[];
  constructor(docSymbols: vscode.DocumentSymbol[]) {
    this.docSymbols = docSymbols;
  }
  public enterProgram(ctx: ProgramContext) {
    const sym = this.createEmptyRegion("Whole Program");
    this.regionList.push(sym);
    this.docSymbols.push(sym);
  }
  public exitProgram(ctx: ProgramContext) {
    const startToken = ctx.start;
    const stopToken = ctx.stop!;
    this.regionList[0].range = new vscode.Range(
      startToken.line,
      startToken.charPositionInLine,
      stopToken.line,
      stopToken.charPositionInLine,
    );
    const sym = this.regionList.pop()!;
  }
  public enterOBlock(ctx: OBlockContext) {
    const sym = this.createEmptyRegion(" ");
    if (this.regionList.length !== 0) {
      this.regionList[this.regionList.length - 1].children.push(sym);
    }
    this.regionList.push(sym);
  }
  public exitOBlock(ctx: OBlockContext) {
    const startToken = ctx.start;
    const stopToken = ctx.stop!;
    const fullRange = new vscode.Range(
      startToken.line,
      startToken.charPositionInLine,
      stopToken.line,
      stopToken.charPositionInLine,
    );
    const nameToken = ctx.O_BLOCK_NUMBER().symbol;
    const nameRange = new vscode.Range(
      nameToken.line,
      nameToken.charPositionInLine,
      nameToken.line,
      nameToken.stopIndex - nameToken.startIndex,
    );
    const blockName = ctx.O_BLOCK_NUMBER().text;
    const region = this.regionList.pop()!;
    region.name = blockName;
    region.range = fullRange;
    region.selectionRange = nameRange;
  }
  private createEmptyRegion(name: string) {
    return new vscode.DocumentSymbol(
      name,
      "",
      vscode.SymbolKind.Function,
      new vscode.Range(0, 0, 1, 1),
      new vscode.Range(0, 0, 1, 1),
    );
  }
}
