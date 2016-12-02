package main

import "fmt"

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
            if (now > 3) {
                diff = -3
            }
        case 'D':
            if (now < 7) {
                diff = +3
            }
        case 'L':
            if (now%3 != 1) {
                diff = -1
            }
        case 'R':
            if (now%3 != 0) {
                diff = +1
            }
        default:
            diff = 0
        }
        now += diff
    }
    return now
}

func main() {
    fmt.Println("hi")
    var cur int = 5
    var digits []int
    lines := read()
    for _,line := range lines {
        cur = parse(line, cur)
        digits = append(digits, cur)
    }
    for _,digit := range digits {
        fmt.Printf("%d ", digit)
    }
}
