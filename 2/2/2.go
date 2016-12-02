package main

import "fmt"

var pad = []rune {
    000,000,'1',000,000,
    000,'2','3','4',000,
    '5','6','7','8','9',
    000,'A','B','C',000,
    000,000,'D',000,000,
}

func read() (lines []string) {
    var arr []string
    for {
        var input string
        _,err := fmt.Scanln(&input)
        if err != nil {
            break
        } else if len(input) > 0 {
            arr = append(arr, input)
        }
    }
    return arr
}

func parse(str string, start int) (int) {
    now := start
    for _,char := range str {
        var diff int
        switch char {
        case 'U':
            diff = -5
        case 'D':
            diff = +5
        case 'L':
            diff = -1
        case 'R':
            diff = +1
        default:
            diff = 0
        }
        next := now+diff
        if (next > 0) && (next < len(pad)) && (pad[next] != 0) {
            now += diff
        }
    }
    return now
}

func main() {
    fmt.Println("hi")
    var cur int = 10
    var digits []rune
    lines := read()
    for _,line := range lines {
        cur = parse(line, cur)
        digits = append(digits, pad[cur])
    }
    for _,digit := range digits {
        fmt.Printf("%c ", digit)
    }
}
