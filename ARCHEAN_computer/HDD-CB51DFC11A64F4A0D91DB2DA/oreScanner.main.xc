include "oreScannerIO.xc"
include "pivotIO.xc"

; Configurable settings
var $coneAngle = 360
var $direction = 1
var $increment = 2
var $oreToScanFor = "Au"

var $angle = 0
var $bestAngle = 0
var $bestResult = 0
var $oreDistance = 0

function @initialize()
	$bestAngle = 0
	$bestResult = 0
	$oreDistance = 0
	$angle = $coneAngle/2
	$distanceOfBestOre = 0
	$bestOreConcentration = 0

init
	@initialize()

function @controlScanner()
	@sendPivotAngle($angle)
	var $leftLimit = $coneAngle/2
	var $rightLimit = $coneAngle/2 * -1
	if ($angle > $leftLimit)
		$direction = -1
		@initialize()
	
	if ($angle < $rightLimit)
		$direction = 1
		@initialize()
		
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
		
	