<?php
print("hi\n");

$count = 0;
$index = 0;
while ($line = fgets(STDIN))
{
    list ($a,$b,$c) = preg_split('/\s+/', trim($line));
	$triangle[3*floor($index/3)+0][$index%3] = $a;
	$triangle[3*floor($index/3)+1][$index%3] = $b;
	$triangle[3*floor($index/3)+2][$index%3] = $c;
	$index++;
}
foreach ($triangle as list ($a,$b,$c))
{
    $validA = $a < ($b+$c);
    $validB = $b < ($a+$c);
    $validC = $c < ($a+$b);
    $valid = ($validA && $validB && $validC);
    print(($valid?'T':'f')."\t".$a."\t".$b."\t".$c."\n");
	if ($valid) $count++;
}
print($count."/".$index."\n");
?>
