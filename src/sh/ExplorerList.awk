BEGIN {
    j = 1
}

$0=="./"n {
    foo=1
}

{
    i = i % h + 1
    if (i in buf) {
        j = j % h + 1
    }
    buf[i] = substr($0, 3)
}

END {
    while (j in buf) {
        print buf[j]
        j = j % h + 1
    }
}
