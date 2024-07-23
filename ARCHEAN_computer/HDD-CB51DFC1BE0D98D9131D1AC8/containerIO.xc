
function @getContainerContentsWithAlias($alias : text) : text
	return input_text($alias, 0)

function @getContainerItemAmountWithAlias($alias : text, $key : text) : number
	if ($key == "")
		return 0
	var $contents = @getContainerContentsWithAlias($alias)
	return $contents.$key
	
	