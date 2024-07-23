array $keyValuePair : text
var $keyValuePairIndex = 0

function @clearKeyValuePairStack()
	$keyValuePair.clear()

function @getKeyValuePairLastKey() : text
	if ($keyValuePair.size > 0)
		var $last = $keyValuePair.last
		foreach $last ($key, $value)
			return $key
	else
		return ""
		
function @getKeyValuePairLastValue() : number
	if ($keyValuePair.size > 0)
		var $last = $keyValuePair.last
		foreach $last ($key, $value)
			return $value:number
	else
		return ""

function @keyValuePairPop()
	if ($keyValuePair.size > 0)
		$keyValuePair.pop()
	
function @getKeyValuePair() : text
	var $keyValuePairText = ""
	$keyValuePairText.from($keyValuePair)
	return $keyValuePairText
	
function @getKeyAtIndex($index : number) : text
	var $singleKeyValue = $keyValuePair.$index
	foreach $singleKeyValue ($key, $value)
		return $key
		
function @getValueAtIndex($index : number) : number
	var $singleKeyValue = $keyValuePair.$index
	foreach $singleKeyValue ($key, $value)
		return $value
	
function @getKeyValuePairSize() : number
	return $keyValuePair.size
	
function @pushKeyValuePair($keyToPush : text, $valueToPush : number)
	$keyValuePair.append("." & $keyToPush & "{" & $valueToPush:text & "}")
	
function @prependKeyValuePair($keyToPrepend : text, $valueToPrepend : number)
	if ($keyValuePair.size == 0)
		$keyValuePair.append("." & $keyToPrepend & "{" & $valueToPrepend:text & "}")
	else
		$keyValuePair.insert(0, "." & $keyToPrepend & "{" & $valueToPrepend:text & "}")	
		
	