include "keyValueStack.xc"

; Set this to the alias of your crafter. An alias must be set.
const $crafterAlias = "crafter"

; Private variables. Do not change.
const $crafterProgressChannel = 0
const $crafterSelectedRecipeChannel = 1
const $crafterOnOffChannel = 0
const $crafterRecipeChannel = 1
const $crafterAccess = "crafter"

function @getCrafterProgress() : number
	return input_number($crafterAlias, $crafterProgressChannel)
	
function @getCrafterSelectedRecipe() : text
	return input_text($crafterAlias, $crafterSelectedRecipeChannel)

function @getCategories() : text
	return get_recipes_categories("crafter")
	
function @getRecipiesForCategory($category : text) : text
	return get_recipes($crafterAccess, $category)

function @getCategoryForRecipe($recipeToFind:text) : text
	array $categories : text
	$categories.from(get_recipes_categories($crafterAccess), ",")
	
	foreach $categories ($categoryIndex, $category)
		array $recipes : text
		$recipes.from(get_recipes($crafterAccess, $category), ",")
		
		foreach $recipes ($recipeIndex, $recipe)
			if ($recipe == $recipeToFind)
				return $category
	return ""
	
function @getDependentRecipes($recipe : text, $amountMultiplier : number) : text
	var $recipes = get_recipe($crafterAccess, @getCategoryForRecipe($recipe), $recipe)
	foreach $recipes ($recipeLoop, $amount)
		$recipes.$recipeLoop = $amount * $amountMultiplier
	return $recipes
	
function @setCrafterRecipe($recipe:text)
	output_text($crafterAlias, $crafterRecipeChannel, $recipe)
	
function @turnOnCrafter()
	output_number($crafterAlias, $crafterOnOffChannel, 1)
	
function @turnOffCrafter()
	@setCrafterRecipe("")
	output_number($crafterAlias, $crafterOnOffChannel, 0)
	
function @createKeyValueStackOfDependencies($rootRecipe:text, $rootAmount:number)
	var $index = 0
	var $validAmounts = ""
	@pushKeyValuePair($rootRecipe, $rootAmount)
	$validAmounts.$rootRecipe = $rootAmount
	
	while ($index < @getKeyValuePairSize()
		var $recipe = @getKeyAtIndex($index)
		var $amount = @getValueAtIndex($index)
		var $dependencies = @getDependentRecipes($recipe, $amount)
		if ($dependencies != "")
			foreach $dependencies ($dRecipe, $dAmount)
				var $dDependencies = @getDependentRecipes($dRecipe, $dAmount)
				if ($dDependencies != "")
					@pushKeyValuePair($dRecipe, $dAmount)
					$validAmounts.$dRecipe = $validAmounts.$dRecipe + $dAmount
		$index++
		
	var $temp = ""
	$index = $keyValuePair.size - 1
	while ($index >= 0)
		var $key = @getKeyAtIndex($index)
		var $validAmount = $validAmounts.$key
		$temp.$key = $validAmount
		$index--
	
	@clearKeyValuePairStack()
	foreach $temp ($recipe, $amount)
		@prependKeyValuePair($recipe, $amount)
		
; A desired recipe is an item which can be placed in the world. It is not
; a sub part or sub recipe.
function @getDesiredRecipes() : text
	var $desigedRecipes = ""

;	array $categories : text
;	$categories.from(@getCategories(), ",")

;	foreach $categories ($catIndex, $category)
;		if  (($category == "COMPONENTS") or ($category == "SPOOLS") or ($category == "TOOLS") or ($category == "CONSTRUCTION"))
;			array $recipes : text
;			$recipes.from(@getRecipiesForCategory($category), ",")
		
;			foreach $recipes ($recipesIndex, $recipe)
;				$desigedRecipes.$recipe = 0

	var $key = "CompositeBlock"
	$desigedRecipes.$key = 2000
	$key = "ConcreteBlock"
	$desigedRecipes.$key = 2000
	$key = "SteelBlock"
	$desigedRecipes.$key = 2000
	$key = "SteelBeam"
	$desigedRecipes.$key = 1000
	$key = "FluidPort"
	$desigedRecipes.$key = 10
	$key = "FluidJunction"
	$desigedRecipes.$key = 10
	return $desigedRecipes
	
	