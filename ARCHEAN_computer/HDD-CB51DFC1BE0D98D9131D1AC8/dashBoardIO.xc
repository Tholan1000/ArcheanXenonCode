var $screen = screen("screen", 0)

const $triangleHeight = 6
const $triangleWidth = 6
var $componentColor = white
var $backGroundColor = black

function @setTextSize($size:number)
	$screen.text_size($size)

function @upOrDownButtonTriangle($topPointX:number, $topPointY:number, $direction:number) : number
	var $leftPointX = $topPointX - $triangleWidth/2
	var $leftPointY = $topPointY + ($triangleHeight * $direction)
	var $rightPointX = $topPointX + $triangleWidth/2
	var $rightPointY = $leftPointY
	return $screen.button_triangle($topPointX, $topPointY, $leftPointX, $leftPointY, $rightPointX, $rightPointY, $componentColor, $componentColor)
	
function @upButtonTriangle($topPointX:number, $topPointY:number) : number
	return @upOrDownButtonTriangle($topPointX, $topPointY - 1, 1)

function @downButtonTriangle($topPointX:number, $topPointY:number) : number
	return @upOrDownButtonTriangle($topPointX, $topPointY + 1, -1)
	
function @upDownButtonTriangles($middlePointX:number, $middlePointY:number) : number
	var $upTriangleStartY = $middlePointY - $triangleHeight
	if (@upButtonTriangle($middlePointX, $upTriangleStartY))
		return 1
	var $downTriangleStartY = $middlePointY + $triangleHeight
	if (@downButtonTriangle($middlePointX, $downTriangleStartY))
		return -1
	return 0

function @blankScreen()
	$screen.blank($backGroundColor)
	
function @addCharWidth($numChars:number) : number
	return $screen.char_w * $numChars
	
function @progressBar($value:number, $maxValue:number, $topLeftX:number, $topLeftY:number, $width:number)
	if ($maxValue == 0)
		$maxValue = 1
	if ($value > $maxValue)
		$value = $maxValue
	$topLeftY = $topLeftY - 2
	var $bottomRightY = $topLeftY + $screen.char_h + 2
	var $progressColor = color(0, 320, 0)
	var $progressWidth = ($value/$maxValue) * $width
	$screen.draw_rect($topLeftX, $topLeftY, $topLeftX + $width, $bottomRightY, blue, $backGroundColor)
	$screen.draw_rect($topLeftX, $topLeftY, $topLeftX + $progressWidth, $bottomRightY, blue, $progressColor)

function @counter($label:text, $currentValue:number, $desiredValue:number, $topLeftX:number, $topLeftY:number) : number
	var $labelWidth = @addCharWidth(30)
	var $progressWidth = $labelWidth
	@progressBar($currentValue, $desiredValue, $topLeftX, $topLeftY, $labelWidth)
	var $startAt = $topLeftX + 2
	$screen.write($startAt, $topLeftY, $componentColor, $label)
	$startAt = $startAt + $labelWidth
	var $valueStartAt = $startAt;
	$startAt = $startAt + @addCharWidth(3) + 2
	var $newValue = $desiredValue + @upDownButtonTriangles($startAt, $topLeftY + 3)
	if ($desiredValue < 0)
		$desiredValue = 0
	$screen.write($valueStartAt, $topLeftY, $componentColor, $desiredValue:text)
	
	return $newValue
	


