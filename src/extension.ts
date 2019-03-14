"use strict";
import { Trie } from "tiny-trie";
import * as vscode from "vscode";
import { CentroidCompletionProvider } from "./CentroidCompletionProvider";
import { CentroidDeclarationProvider } from "./CentroidDeclarationProvider";
import { CentroidHoverProvider } from "./CentroidHoverProvider";
import { CentroidReferenceProvider } from "./CentroidReferenceProvider";
import { DocumentSymbolManager } from "./DocumentManager";

const centroidScheme = { language: "centroid-gcode", scheme: "file" };

export function activate(context: vscode.ExtensionContext) {
  console.log("Activating!");
  DocumentSymbolManager.init(context);
  context.subscriptions.push(
    vscode.languages.registerHoverProvider(
      centroidScheme,
      new CentroidHoverProvider()
    )
  );

  context.subscriptions.push(
    vscode.languages.registerDeclarationProvider(
      centroidScheme,
      new CentroidDeclarationProvider()
    )
  );

  context.subscriptions.push(
    vscode.languages.registerReferenceProvider(
      centroidScheme,
      new CentroidReferenceProvider()
    )
  );

  context.subscriptions.push(
    vscode.languages.registerCompletionItemProvider(
      centroidScheme,
      new CentroidCompletionProvider()
    )
  );

  context.subscriptions.push(
    vscode.workspace.onDidOpenTextDocument((document: vscode.TextDocument) => {
      if (document.languageId === "centroid-gcode") {
        DocumentSymbolManager.parseAndAddDocument(document);
      }
    })
  );
  context.subscriptions.push(
    vscode.workspace.onDidSaveTextDocument((document: vscode.TextDocument) => {
      if (document.languageId === "centroid-gcode") {
        DocumentSymbolManager.resetDocument(document);
      }
    })
  );
  context.subscriptions.push(
    vscode.workspace.onDidCloseTextDocument((document: vscode.TextDocument) => {
      if (document.languageId === "centroid-gcode") {
        DocumentSymbolManager.removeDocument(document);
      }
    })
  );
  for (let i = 0; i < vscode.workspace.textDocuments.length; ++i) {
    if (vscode.workspace.textDocuments[i].languageId === "centroid-gcode") {
      DocumentSymbolManager.parseAndAddDocument(
        vscode.workspace.textDocuments[i]
      );
    }
  }
}
