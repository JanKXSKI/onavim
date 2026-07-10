if !exists("g:codeSessionsFile")
    finish
endif

let g:codeAutocommandsEnabled = 1

if exists("g:codeSessionsFile")
    function! CodeCloseWithNext(nextSessionPath)
        if !g:codeAutocommandsEnabled
            return
        endif
        call system(expand("<script>:h").."/../../../sh/WriteLeastRecentlyUsed "..g:codeSessionsFile.." "..a:nextSessionPath)
        let l:vimSessionsDir = fnamemodify(g:codeSessionsFile, ":p:h").."/vim-sessions"
        call mkdir(l:vimSessionsDir, "p")
        exe "mksession! "..l:vimSessionsDir.."/"..fnamemodify(getcwd(), ":gs#/#ESCAPED_SLASH#")..".vim"
    endfunction

    autocmd VimLeave * call CodeCloseWithNext(g:codeCurrentSession)
endif
