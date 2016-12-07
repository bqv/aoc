8 constant WordLen
26 constant AbetLen
create ADicts AbetLen WordLen * allot

: get-dict ( array index -- dict )
    AbetLen * +
;

: read-dict ( dict len -- )
    .\" \n"
    0 do
        dup I + c@ .
    loop drop
    .\" \n"
;

: read-dicts ( array -- )
    WordLen 0 do
        dup I get-dict AbetLen read-dict
    loop drop
;

: letter-index ( char -- int )
    'a - 1+ 
;

: inc-dict ( index dict -- val )
    1- + dup c@
    1+ dup rot c! 
;

: process-line
    pad dup WordLen 2 + stdin read-line drop if \ <> pad count
        drop WordLen 0 do
            dup I + c@ \ <> pad char
            dup emit letter-index \ <> pad int
            ADicts I get-dict inc-dict drop \ <> pad
        loop drop true
    else
        2drop false
    then .\" \n"
;

: process-input
    begin
        process-line while
    repeat
;

: dict-max ( dict -- index )
    0 \ <> dict &cur
    AbetLen 0 do
        tuck over + c@ \ <> &cur dict *cur 
        over I + c@ swap \ <> &cur dict cell val *cur
        < if
            I \ <> &oldcur dict &cur 
        else
            over \ <> &cur dict &cur
        then rot drop \ <> dict &cur
    loop nip 1+ \ <> index
;

: print-maxes ( array -- )
    WordLen 0 do
        dup I get-dict dict-max 
        1- 'a + emit
    loop drop
;

ADicts AbetLen WordLen * 0 fill
process-input
ADicts read-dicts
ADicts print-maxes

.\" \n\nStack: " .s bye
