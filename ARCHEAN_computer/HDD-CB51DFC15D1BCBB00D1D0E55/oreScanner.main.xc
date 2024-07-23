include "oreScannerIO.xc"
include "pivotIO.xc"

; Configurable settings
var $coneAngle = 360
var $direction = 1
var $increment = 0.3
var $oreToScanFor = "Au"

var $angle = 0
var $bestAngle = 0
var $bestResult = 0
var $oreDistance = 0

function @controlScanner()
	@sendPivotAngle($angle)
	if ($angle > $coneAngle/2)
		$direction = -1
	if ($angle < ($coneAngle/2) * -1)
		$direction = 1
	$angle = $angle + ($increment * $direction)
	
update
	@controlScanner()
	@scanForOre()
	@storeBestOreResults($oreToScanFor)
	
	if ($bestOreConcentration > $bestResult)
		$bestResult = $bestOreConcentration
		$bestAngle = $angle
		$oreDistance = $distanceOfBestOre
	
	print("Best result for " & $oreToScanFor & " = " & $bestResult:text & " at an angle of " & $bestAngle:text & " at a distance of " & $oreDistance:text)
		
	