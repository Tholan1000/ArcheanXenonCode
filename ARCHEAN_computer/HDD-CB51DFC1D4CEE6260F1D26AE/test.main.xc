var $scannerSpeed = 0.0
var $oreFoundResult:text
var $oreFound = 0
var $orePercent = "Empty"
var $screenAlias = "screen"
var $distanceFound = 0
; var $screen = screen("screen", 0)

tick
;	output_text($screenAlias, 0, "Print to screen via output text")
;	$screen.write("Print to screen via .... alias write")
;	screen("screen", 0).write(0, 0, green, "Hello")
	
	output_number(7, 0, $scannerSpeed)
	
	repeat 100 ($channel)
		var $distance = $channel * 50
		output_number(6, $channel, $distance)
		var $oreResult = input_text(6, $channel)
		; print($oreResult)
		
		foreach $oreResult ($key, $value)
			if ($key == "Au")
				$orePercent = $value
				$oreFound = 1
				$distanceFound = $distance
				output_text("screen", 0, "This way")
				break
		
	if ($oreFound == 1)
		output_text("screen", 0, "Found Au \n" & $orePercent & "\nat a distance of " & $distanceFound:text)
		print("Found Au " & $orePercent & " at a distance of " & $distanceFound:text)
	else
		output_text("screen", 0, "Still searching")
	
;	foreach $oreResult ($key, $value)
;		if ($key == "Au")
;			output_number(11, 0, $scannerSpeed)
;			$orePercent = $value
;			$oreFound = 1
;			print("Found it in loop")
;			break
;			
;	if ($oreFound == 1)
;		print("WE FOUND IT!!!! Au with a value of")
;		print($orePercent)
;		print($oreResult)
	