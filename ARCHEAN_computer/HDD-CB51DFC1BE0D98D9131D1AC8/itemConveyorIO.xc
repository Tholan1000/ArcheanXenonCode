const $filterConveyorAlias = "filterConveyor"

const $filterConveyorOnOffChannel = 0
const $filterConveyorStackSizeChannel = 1
const $filterConveyorFilterChannel = 2

function @turnOnConveyor()
	output_number($filterConveyorAlias, $filterConveyorOnOffChannel, 1)
	
function @turnOffConveyor()
	output_number($filterConveyorAlias, $filterConveyorOnOffChannel, 0)
	
function @setConveyorStackSize($stackSize : number)
	output_number($filterConveyorAlias, $filterConveyorStackSizeChannel, $stackSize)
	
function @setConveyorFilter($filter : text)
	output_text($filterConveyorAlias, $filterConveyorFilterChannel, $filter)
