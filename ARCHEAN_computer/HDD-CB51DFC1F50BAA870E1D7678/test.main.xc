var $scannerSpeed = 0.02
var $oreFoundResult:text
var $oreFound = 0
var $orePercent = "Empty"

update
	$oreFound = 0
	output_number(7, 0, $scannerSpeed)
	
	output_number(6, 1, 1000)
	var $oreResult = input_text(6, 1)
	
	foreach $oreResult ($key, $value)
		if ($key == "Au")
			$scannerSpeed = 0
			output_number(11, 0, $scannerSpeed)
			$orePercent = $value
			$oreFound = 1
			print("Found it in loop")
			break
		else
			print("Still Looking")
			
	if ($oreFound == 1)
		print("WE FOUND IT!!!! Au with a value of")
		print($orePercent)
		print($oreResult)
	