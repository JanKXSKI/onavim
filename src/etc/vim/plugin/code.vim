if !exists("g:codeSessionsFile")
    finish
endif

let g:codeUserWinId = 0
let g:codeCurrentRelativePath = ""
let g:codeAutocommandsEnabled = 1

function! CodeShouldRunAuto()
    return g:codeAutocommandsEnabled && g:codeUserWinId == win_getid()
endfunction

if exists("g:codeSessionsFile")
    function! CodeCloseWithNext(nextSessionPath)
        if !CodeShouldRunAuto()
            return
        endif
        call system(expand("<script>:h").."/../../../sh/WriteLeastRecentlyUsed "..g:codeSessionsFile.." "..a:nextSessionPath)
        let l:vimSessionsDir = fnamemodify(g:codeSessionsFile, ":p:h").."/vim-sessions"
        call mkdir(l:vimSessionsDir, "p")
        exe "mksession! "..l:vimSessionsDir.."/"..fnamemodify(getcwd(), ":gs#/#ESCAPED_SLASH#")..".vim"
    endfunction

    autocmd VimLeave * call CodeCloseWithNext(g:codeCurrentSession)
endif
