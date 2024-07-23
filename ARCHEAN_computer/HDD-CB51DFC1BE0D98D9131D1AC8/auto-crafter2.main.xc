include "crafterIO.xc"
include "dashBoardIO.xc"
include "autoCrafterContainer.xc"

var $desiredRecipes : text
var $desiredRecipeArrayIndex = 0
var $itemToCraft = ""
var $requiredAmountOfItem = 0
var $startCrafting = 0
var $craftItemAndAllDependencies = 0
var $currentRecipe : text
var $amountRequired : number
var $craftFailed = 0
	
init
	@turnOffCrafter()
	$desiredRecipes = @getDesiredRecipes()

function @handleUi()
	@blankScreen()
	var $rowHeight = $screen.char_h + 8
	var $tableMargin = 6
	var $rowIndex = 0
	foreach $desiredRecipes ($recipe, $amount)
		var $row = $rowHeight * $rowIndex + $tableMargin
		$desiredRecipes.$recipe = @counter($recipe, @getContainerItemAmount($recipe), $desiredRecipes.$recipe, 6, $row)
		$rowIndex++
	
function @setNextItemToCraftAndItemFilter()
	$itemToCraft = ""
	$requiredAmountOfItem = 0
	array $desiredRecipesArray : text
	$desiredRecipesArray.clear()
	foreach $desiredRecipes ($recipe, $amount)
		$desiredRecipesArray.append("." & $recipe & "{" & $amount & "}")
	
	if ($desiredRecipeArrayIndex < $desiredRecipesArray.size)
		var $singleKeyValue = $desiredRecipesArray.$desiredRecipeArrayIndex
		foreach $singleKeyValue ($key, $value)
			if (@getContainerItemAmount($key) < $value)
				$itemToCraft = $key
				$requiredAmountOfItem = $value

	if ($desiredRecipeArrayIndex > $desiredRecipesArray.size)
		$desiredRecipeArrayIndex = -1

function @craftItemAndAllDependencies()
	if (@getContainerItemAmount($currentRecipe) < $amountRequired)
		@turnOnCrafter()
		@setCrafterRecipe($currentRecipe)
		if (@getCrafterProgress() == -1)
			print("Error crafting " & $currentRecipe)
			$craftFailed = 1
	else
		print("Finished item " & $currentRecipe)
		@keyValuePairPop()
		$currentRecipe = @getKeyValuePairLastKey()
		$amountRequired = @getKeyValuePairLastValue()

function @incrementDesiredRecipesIndex()
	$desiredRecipeArrayIndex++
	$craftItemAndAllDependencies = 0

function @handleError()
	print("Handle error by moving onto next. Eventually show red in UI")
	@incrementDesiredRecipesIndex()
	$craftFailed = 0
	
update
	@handleUi()
	if ($craftFailed)
		@handleError()
	else
		@setNextItemToCraftAndItemFilter()
		$startCrafting = (@getContainerItemAmount($itemToCraft) < $requiredAmountOfItem)
		if ($startCrafting)
			if ($craftItemAndAllDependencies == 0)
				@clearKeyValuePairStack()
				@createKeyValueStackOfDependencies($itemToCraft, $requiredAmountOfItem)
				$currentRecipe = @getKeyValuePairLastKey()
				$amountRequired = @getKeyValuePairLastValue()
				$craftItemAndAllDependencies = 1
				print("Craft item with dependencies " & @getKeyValuePair())
			else
				@craftItemAndAllDependencies()
		else
			@turnOffCrafter()
			@setCrafterRecipe("Nothing")
			@incrementDesiredRecipesIndex()

	
	