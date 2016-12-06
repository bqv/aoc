PackageLoader fileInPackage: 'Digest' !

'hi' displayNl.

input := stdin nextLine.
result := ''.
count := 0.
i := 0.
[count < 8] whileTrue: [ 
    str := input , i asString.
    hash := (MD5 hexDigestOf: str).
    str display.
    ' ' display.
    hash display.
    ' ' display.
    (hash startsWith: '00000')
        ifTrue: [
            char := (hash asArray) at: 6.
            result := result , char asString.
            count := count + 1.
            result displayNl
        ]
        ifFalse: [
            Character cr display
        ].
    i := i + 1
].
' ' displayNl.
result displayNl.
