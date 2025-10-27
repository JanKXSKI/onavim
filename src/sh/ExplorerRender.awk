BEGIN {
    ses[0] = " "
    ses[1] = "│"
    ses[2] = "╰"
    ses[3] = "╰"
}

{
    print $0
}
