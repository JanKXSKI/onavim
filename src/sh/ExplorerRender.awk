function line(path, bcolor) {
    if (NR > 1) printf "\n"
    printf bcolor
    fields = split(path, segments, "/")
    leaf = segments[fields]
    level = length(segments)-1
    folds = ""
    while (level > 5) {
        folds = folds ">"
        level -= 4
    }
    indent = sprintf("%-*.*s", level, level, folds)
    prei = sprintf("%-*.*s%s", w-1, w-1, indent ":" " " leaf, "\033[K\033[0m")
    sub(":", icon["color"] icon["char"] "\033[0m" bcolor, prei)
    printf prei
}

function setIcon(path, suffix, active) {
    if (suffix == "d" && active) {
        icon["char"] = "▢"
        icon["color"] = "\033[38;5;51m"
    }
    else if (suffix == "d" && !active) {
        icon["char"] = "▣"
        icon["color"] = "\033[38;5;31m"
    }
    else if (path == "CMakeLists.txt") {
        icon["char"] = "△"
        icon["color"] = active ? "\033[38;5;46m" : "\033[38;5;28m"
    }
    else {
        icon["char"] = "◰"
        icon["color"] = active ? "\033[38;5;229m" : "\033[38;5;172m"
    }
}

$1==p {
    setIcon($1, $2, 1)
    line($1, "\033[48;5;240m")
    next
}

match(p, "^" $1 "/") {
    setIcon($1, $2, 1)
    line($1, "\033[0m")
    next
}

{
    setIcon($1, $2, 0)
    line($1, "\033[0m\033[38;5;245m")
}
