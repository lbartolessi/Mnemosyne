import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';

export function activate(context: vscode.ExtensionContext) {
    console.log('Mnemosyne is now active.');

    // 1. Command: Initialize
    let initDisposable = vscode.commands.registerCommand('mnemosyne.initialize', async () => {
        await initializeProject(context);
    });

    // 2. Command: Sync Date (Runs automatically on startup if configured, but we register it manually too)
    let syncDisposable = vscode.commands.registerCommand('mnemosyne.syncDate', () => {
        syncSessionDate();
    });

    context.subscriptions.push(initDisposable);
    context.subscriptions.push(syncDisposable);

    // Auto-run sync date on activation
    syncSessionDate();
}

async function initializeProject(context: vscode.ExtensionContext) {
    const workspaceFolders = vscode.workspace.workspaceFolders;
    if (!workspaceFolders) {
        vscode.window.showErrorMessage("Mnemosyne: Open a folder to initialize.");
        return;
    }
    const rootPath = workspaceFolders[0].uri.fsPath;
    
    // Configuration
    const config = vscode.workspace.getConfiguration('mnemosyne');
    const docsPath = path.join(rootPath, config.get('paths.docs') as string);
    const corePath = path.join(rootPath, config.get('paths.core') as string);

    // IDE Detection
    const isCursor = vscode.env.appName.toLowerCase().includes('cursor');

    // Templates Path
    const templatesPath = path.join(context.extensionPath, 'templates');

    try {
        // 1. Copy Static Core (.vscode/mnemosyne-core)
        await copyTemplate(path.join(templatesPath, 'core'), corePath);

        // 2. Copy Variable Project Files (docs/mnemosyne) - Do not overwrite if exists
        await copyTemplate(path.join(templatesPath, 'project'), docsPath, false);

        vscode.window.showInformationMessage(`Mnemosyne initialized in ${docsPath} and ${corePath}`);

        if (isCursor) {
            const cursorRulesPath = path.join(rootPath, '.cursor', 'rules');
            await copyTemplate(path.join(templatesPath, 'cursor'), cursorRulesPath);
            vscode.window.showInformationMessage("Cursor detected: Rules injected into .cursor/rules");
        } else {
            // VS Code specific reminder
            vscode.window.showInformationMessage(
                "VS Code detected: Please manually add 'docs/mnemosyne' and '.vscode/mnemosyne-core' to your AI context (Copilot/Gemini)."
            );
        }

    } catch (error: any) {
        vscode.window.showErrorMessage(`Mnemosyne Init Failed: ${error.message}`);
    }
}

async function copyTemplate(src: string, dest: string, overwrite = true) {
    if (!fs.existsSync(src)) { return; }
    if (!fs.existsSync(dest)) { fs.mkdirSync(dest, { recursive: true }); }

    const entries = fs.readdirSync(src, { withFileTypes: true });

    for (const entry of entries) {
        const srcPath = path.join(src, entry.name);
        const destPath = path.join(dest, entry.name);

        if (entry.isDirectory()) {
            await copyTemplate(srcPath, destPath, overwrite);
        } else {
            if (!overwrite && fs.existsSync(destPath)) {
                continue; // Skip existing files for project data
            }
            fs.copyFileSync(srcPath, destPath);
        }
    }
}

function syncSessionDate() {
    // TODO: Implement date writing logic
}

export function deactivate() {}