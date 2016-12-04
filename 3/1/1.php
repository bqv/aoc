<?php
print("hi\n");

$count = 0;
while ($line = fgets(STDIN))
{
    list ($a,$b,$c) = preg_split('/\s+/', trim($line));
    $validA = $a < ($b+$c);
    $validB = $b < ($a+$c);
    $validC = $c < ($a+$b);
    $valid = ($validA && $validB && $validC);
    print($valid."\t".$a."\t".$b."\t".$c."\n");
	if ($valid) $count++;
}
print($count);
?>
