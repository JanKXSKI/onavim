let s:bindPreviewUpDown = "'--bind', 'ctrl-u:preview-half-page-up', '--bind', 'ctrl-d:preview-half-page-down'"
let s:bindClearQuery = "'--bind', 'ctrl-l:clear-query'"
let s:defaultBinds = s:bindPreviewUpDown..", "..s:bindClearQuery

let s:source = "'git ls-files'"
let s:allFiles = "find . -path ./.git -prune -or \"(\" -type f -or -type l \")\" -and ! -name *.swp -print | gsed s#^\\./##"
let s:preview = "'bat -n --color=always {}'"
let s:bindGitLs = "'--bind', 'ctrl-g:reload("..s:allFiles..")'"
let s:options = "['--preview', "..s:preview..", "..s:defaultBinds..", "..s:bindGitLs.."]"
exe "command OpFile call fzf#run(fzf#wrap({'source': " s:source ",'options':" s:options ", 'sink': 'edit'}))"

let s:source = "'git log --format=''%h %an %ar: %s'' -- '..expand('%')"
let s:previewGit = "'echo {} | gawk ''{print $1}'' | xargs -I{} git show {}:'..expand('%')"
let s:preview = s:previewGit.."..' | bat -n --color=always -l='..split(expand('%:t'), '\\.')[-1]"
let s:previewWindow = "'+'..line('w0')"
let s:options = "['--preview', "..s:preview..", '--preview-window', "..s:previewWindow..", "..s:defaultBinds.."]"
exe "command OpGitLog call fzf#run(fzf#wrap({'source': " s:source ", 'options':" s:options "}))"

if exists("g:codeOpGrepServerSocket")
    function! OpGrepSink(selected)
        call map(a:selected, 'split(v:val, ":")[0]')
        if len(a:selected) == 1
            let l:ch = ch_open("unix:"..g:codeOpGrepServerSocket)
            let l:num = ch_evalraw(l:ch, "get\n")
            call ch_close(l:ch)
            let l:file = a:selected[0]
            exe "edit +"..l:num.." "..l:file
        endif
        call map(a:selected, '{ "filename": v:val }')
        call setloclist(0, a:selected, "r")
        ll
    endfunction
    let s:source = "'ag -c <args>'"
    let s:preview = "'bat -n --color=always $("..expand("<script>:h").."/../../../sh/RequestEval "..g:codeOpGrepServerSocket.." preview {1} $FZF_PREVIEW_LINES <args>) {1}'"
    let s:bindNext = "'--bind', 'ctrl-n:refresh-preview'"
    let s:bindIgnore = "'--bind', 'ctrl-g:reload(ag -cU <args>)'"
    let s:bindAll = "'--bind', 'ctrl-a:toggle-all'"
    let s:options = "['-d', ':', '--nth', '1', '--multi', '--preview', "..s:preview..", "..s:bindNext..", "..s:bindClearQuery..", "..s:bindIgnore..", "..s:bindAll.."]"
    exe "command -nargs=+ OpGrep call fzf#run(fzf#wrap({'source': " s:source ", 'options':" s:options ", 'sinklist': function('OpGrepSink')}))"
endif

function OpGrepWithWordUnderCursor()
    call feedkeys(":OpGrep "..expand("<cword>"))
endfunction

if exists("g:codeSessionsFile")
    function! OpenCodeSession(selected)
        try
            sbm
            wincmd J
            echoe "Cannot leave here, buffer has changes."
        catch /No modified buffer/
            call CodeCloseWithNext(a:selected)
            let g:codeAutocommandsEnabled = 0
            qa
        endtry
    endfunction
    let s:source = "'cat "..g:codeSessionsFile.."'"
    let s:options = "["..s:bindClearQuery.."]"
    exe "command OpSession call fzf#run(fzf#wrap({'source': " s:source ", 'options':" s:options ", 'sink': function('OpenCodeSession')}))"
endif
