include "containerIO.xc"

const $containerBaseItems = "baseItems"

function @getContainerContents() : text
	return @getContainerContentsWithAlias($containerBaseItems)

	
function @getContainerItemAmount($item : text) : number
	if ($item == "")
		return 0
	var $contents = @getContainerContents()
	return $contents.$item