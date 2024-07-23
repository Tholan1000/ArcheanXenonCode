include "crafterIO.xc"
include "containerIO.xc"
include "itemConveyorIO.xc"
include "dashBoardIO.xc"

; Public member
var $startCrafting = 0
var $itemToCraft = ""
var $requiredAmountOfItem = 0

; Private members. Do not change
var $currentRecipe : text
var $amountRequired : number
var $startCraftingAtTick = 0
var $crafterStarted = 0
var $crafterRecipeSet = 0
var $retryAttempts = 0
var $doneCraftingItem = 0

; UI members. Do not change.
var $desiredRecipes : text		 ; The amount of each recipe to store.

init
	@blankScreen()
	@turnOffCrafter()
	$desiredRecipes = @getDesiredRecipes()
	
function @getCurrentCraft() : text
	var $containerAmount = @getContainerValue($currentRecipe)
	return "Recipe = " & $currentRecipe & " Amount = " & $amountRequired:text & " Container = " & $containerAmount:text
	
function @handleCrafterStarted()
	if ($crafterRecipeSet == 0)
		@setCrafterRecipe($currentRecipe)
		$crafterRecipeSet = (@getCrafterSelectedRecipe() == $currentRecipe)
		return
	if (@getContainerValue($currentRecipe) < $amountRequired)
		@setCrafterRecipe($currentRecipe)
		if (@getCrafterSelectedRecipe() != $currentRecipe)
			print("Start crafting item " & $currentRecipe & " Crafter recipe = " & @getCrafterSelectedRecipe())
		else
			if (@getCrafterProgress() == -1)
				print("Could not complete crafting " & $currentRecipe)
				if (@getContainerValue($currentRecipe) < $amountRequired)
					var $containerAmount = @getContainerValue($currentRecipe)
					print("Can't craft item " & $currentRecipe & " Crafter recipe = " & @getCrafterSelectedRecipe())
					print("Container amount = " & $containerAmount:text & " Amount required = " & $amountRequired:text)
					$startCrafting = 0
				else
					print("Have enough. Continue crafting. change " & $currentRecipe)
			elseif (@getCrafterProgress() == 1)
				print("Crafting of item " & $currentRecipe & " completed successfully")
			else
				var $progress = @getCrafterProgress() 
				print("Crafting " & $currentRecipe & " Progress = " & $progress:text)
	else
		print("Finished crafting or have enough " & $currentRecipe)
		print(@getCurrentCraft())
		@keyValuePairPop()
		$currentRecipe = @getKeyValuePairLastKey()
		$amountRequired = @getKeyValuePairLastValue()
		print(@getCurrentCraft())
		if (@getKeyValuePairSize() == 0)
			$startCrafting = 0
		else
			$crafterRecipeSet = 0
		
function @shutDownCrafting()
	if ($crafterStarted == 1)
		@setCrafterRecipe("")
		@turnOffCrafter()
		$crafterStarted = 0
		print("Shutting down crafter")
		
function @startCrafting()
	if (@getContainerValue($itemToCraft) >= $requiredAmountOfItem)
		$startCrafting = 0
		$doneCraftingItem = 1
		return
	if ($crafterStarted)
		@handleCrafterStarted()
	else
		if ($startCraftingAtTick == 0)
			$startCraftingAtTick = tick
			@turnOnCrafter()
		else
			if (@getCrafterSelectedRecipe() == $startCraftingAtTick:text)
				$crafterStarted = 1
				$currentRecipe = @getKeyValuePairLastKey()
				if ($currentRecipe == "")
					print("Its empty")
				$amountRequired = @getKeyValuePairLastValue()
			else
				@setCrafterRecipe($startCraftingAtTick:text)

update ; handle crafting
	if ($startCrafting)
		@startCrafting()
	else
		@shutDownCrafting()
;		if (($retryAttempts >= 10) or ($currentRecipe == ""))
;			if (@getDependentRecipes($currentRecipe, $amountRequired) == "")
;				@shutDownCrafting()
;		else
;			$retryAttempts++
;			print("Lets try again")
;			$startCrafting = 1
;			@createKeyValueStackOfDependencies($itemToCraft, $requiredAmountOfItem)
;			$currentRecipe = @getKeyValuePairLastKey()
;			$amountRequired = @getKeyValuePairLastValue()

;
; Filter only usable items into final container.
;
var $categoryIndex : number
var $recipeIndex : number
var $itemFilter : text
var $startItemTransfer = 0

function @isDesiredCategory($category : text) : number
	return (($category == "COMPONENTS") or ($category == "SPOOLS") or ($category == "TOOLS") or ($category == "CONSTRUCTION"))

;update
;	array $categories : text
;	$categories.from(@getCategories(), ",")
;	if ($categoryIndex < $categories.size)
;		var $category = $categories.$categoryIndex
;		if (@isDesiredCategory($category))
;			array $recipes : text
;			$recipes.from(@getRecipiesForCategory($category), ",")
;			$itemFilter = $recipes.$recipeIndex
;			$recipeIndex++
;			if ($recipeIndex >= $recipes.size)
;				$recipeIndex = 0
;				$categoryIndex++
;				if ($categoryIndex >= $categories.size)
;					$categoryIndex = 0
;		else
;			$categoryIndex++
;		if ($categoryIndex >= $categories.size)
;			$categoryIndex = 0			
		
		
function @startItemTransfer()
	if ($itemFilter != "")
		@setConveyorFilter($itemFilter)
		@turnOnConveyor()
	
function @stopItemTransfer()
	@turnOffConveyor()

update ; handling transfer to final container
	if ($startItemTransfer)
		@startItemTransfer()
	else
		@stopItemTransfer()

;
; UI Handling
;
var $desiredRecipeArrayIndex = 0
function @handleUi()
	var $rowIndex = 0
	foreach $desiredRecipes ($recipe, $amount)
		var $row = ($screen.char_h + 12) * $rowIndex + 5
		$desiredRecipes.$recipe = @counter($recipe, $desiredRecipes.$recipe, 6, $row)
		$rowIndex++
		
function @findNextItemToCraft() : text
	var $nextItemToCraft = ""
	array $desiredRecipesArray : text
	$desiredRecipesArray.clear()
	foreach $desiredRecipes ($recipe, $amount)
		$desiredRecipesArray.append("." & $recipe & "{" & $amount & "}")
	
	if ($desiredRecipeArrayIndex < $desiredRecipesArray.size)
		var $singleKeyValue = $desiredRecipesArray.$desiredRecipeArrayIndex
		foreach $singleKeyValue ($key, $value)
			$requiredAmountOfItem = $value
			if ($key != "")
				$itemFilter = $key
			if ($value > 0)
				$nextItemToCraft = $key
				
	if ($desiredRecipeArrayIndex > $desiredRecipesArray.size)
		$desiredRecipeArrayIndex = 0
		
	return $nextItemToCraft

update
	@handleUi()
	var $nextItemToCraft = @findNextItemToCraft()
	
	if ($nextItemToCraft != "")
		if ($nextItemToCraft != $itemToCraft)
			$itemToCraft = $nextItemToCraft
			@createKeyValueStackOfDependencies($itemToCraft, $requiredAmountOfItem)
		
		$currentRecipe = @getKeyValuePairLastKey()
		$amountRequired = @getKeyValuePairLastValue()
		print(@getKeyValuePair())
	else
		$startCrafting = 0
		$itemToCraft = ""
		$doneCraftingItem = 1
	
	if ($itemToCraft != "")
		print("Item to craft " & $itemToCraft)
		$startCrafting = 1
	else
		print("Nothing to craft. Go to next")
		$doneCraftingItem = 0
		$desiredRecipeArrayIndex++

	if (($doneCraftingItem) and ($itemToCraft != ""))
		print("Done. Go to next")
		$itemToCraft = ""
		$desiredRecipeArrayIndex++
	
