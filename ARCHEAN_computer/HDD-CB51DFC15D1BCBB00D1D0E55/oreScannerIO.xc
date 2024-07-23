const $oreScannerAlas = "oreScanner"

var $maxDistanceOfScan = 2000
var $resolution = 5

var $distanceOfBestOre = 0
var $bestOreConcentration = 0

function @scanForOre($channel : number, $distance : number)
	output_number($oreScannerAlas, $channel, $distance)
	
function @getOreResult($channel : number) : text
	return input_text($oreScannerAlas, $channel)
	
function @storeBestOreResults($ore : text)
	var $numChannels = $maxDistanceOfScan / $resolution
	repeat $numChannels ($channel)
		var $distance = $channel * $resolution
		@scanForOre($channel, $distance)
		var $result = @getOreResult($channel)
		if ($result.$ore > $bestOreConcentration)
			$bestOreConcentration = $result.$ore
			$distanceOfBestOre = $distance