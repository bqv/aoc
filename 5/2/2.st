PackageLoader fileInPackage: 'Digest' !

'hi' displayNl.

input := stdin nextLine.
result := '________' copy.
count := 0.
i := 2231000.
[count < 8] whileTrue: [ 
    str := input , i asString.
    hash := (MD5 hexDigestOf: str).
    str display.
    ' ' display.
    hash display.
    ' ' display.
    (hash startsWith: '00000')
        ifTrue: [
            index := ((hash at: 6) asciiValue) - 48 + 1.
            ((index >= 1) & (index <= 8))
                ifTrue: [
                    char := hash at: 7.
                    ((result at: index) = $_) ifTrue: [
                        result at: index put: char.
                        count := count + 1
                    ].
                    result displayNl
                ]
                ifFalse: [
                    Character cr display
                ]
        ]
        ifFalse: [
            Character cr display
        ].
    i := i + 1
].
' ' displayNl.
result displayNl.
