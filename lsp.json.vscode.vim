call LspAddServer([
            \  #{
            \    name: 'vscode-json-server',
            \    filetype: ['json'],
            \    path: 'vscode-json-languageserver',
            \    args: ['--stdio']
            \  }
])
