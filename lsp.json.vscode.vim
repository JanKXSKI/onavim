call LspAddServer([#{
            \ name: 'vscode-json-server',
            \ filetype: ['json'],
            \ path: 'vscode-json-language-server',
            \ args: ['--stdio'],
            \ initializationOptions: #{ provideFormatter: v:true }
            \ }])
