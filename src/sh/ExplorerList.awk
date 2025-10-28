$0=="./"n {
    foundAt = i + 1
}

{
    buf[++i % h + 1] = substr($0, 3)
    if (foundAt && h in buf && i - foundAt > h / 2)
        exit
}

END {
    start = i - h < 1 ? 1 : i - h
    for (k = start; k <= i; ++k)
        print buf[k % h + 1]
}
