#NODES {"nodes":[{"id":"NODECB51DFC1ED6B835FD41C5E6E","inputTypes":[0,0,0,0,0],"inputValues":["1","","","",""],"inputs":["NODECB51DFC1BCDE5F64D41C86E4","NODECB51DFC177993B84D41CC2CC","","",""],"ioNumber":5,"outputType":2,"pos":{"x":126.5,"y":112.5},"size":{"x":155.0,"y":166.0},"title":"output.5","type":"OutputNode"},{"id":"NODECB51DFC19DA9BD61D41C22ED","inputTypes":[0,0,0,0,0],"inputValues":["1","","","",""],"inputs":["NODECB51DFC15FC5DA7CD41CBE14","NODECB51DFC177993B84D41CC2CC","","",""],"ioNumber":11,"outputType":2,"pos":{"x":838.5,"y":64.5},"size":{"x":155.0,"y":166.0},"title":"output.11","type":"OutputNode"},{"channel":1,"id":"NODECB51DFC1BCDE5F64D41C86E4","inputs":[],"ioNumber":9,"outputType":0,"pos":{"x":286.5,"y":20.5},"size":{"x":256.0,"y":66.0},"title":"input.9","type":"InputNode"},{"id":"NODECB51DFC1E0968870D41C7AF8","inputTypes":[0,0,0,0,0],"inputValues":["","","","",""],"inputs":["NODECB51DFC1BCDE5F64D41C86E4","","","",""],"ioNumber":4,"outputType":2,"pos":{"x":125.5,"y":285.5},"size":{"x":155.0,"y":166.0},"title":"output.4","type":"OutputNode"},{"id":"NODECB51DFC12C6B5D71D41C2A2C","inputTypes":[0,0,0,0,0],"inputValues":["","","","",""],"inputs":["NODECB51DFC15FC5DA7CD41CBE14","","","",""],"ioNumber":10,"outputType":2,"pos":{"x":846.5,"y":243.5},"size":{"x":155.0,"y":166.0},"title":"output.10","type":"OutputNode"},{"id":"NODECB51DFC15FC5DA7CD41CBE14","inputTypes":[0],"inputValues":[""],"inputs":["NODECB51DFC1BCDE5F64D41C86E4"],"outputType":0,"pos":{"x":526.5,"y":263.5},"size":{"x":68.0,"y":45.0},"title":"NEGATIVE","type":"MathNode_NEGATIVE"},{"channel":2,"id":"NODECB51DFC177993B84D41CC2CC","inputs":[],"ioNumber":9,"outputType":0,"pos":{"x":559.5,"y":22.5},"size":{"x":211.0,"y":66.0},"title":"input.9","type":"InputNode"}]}

update
	var $_input_number_9_1 = input_number(9, 1)
	output_number(5, 0, $_input_number_9_1)
	var $_input_number_9_2 = input_number(9, 2)
	output_number(5, 1, $_input_number_9_2)
	output_number(11, 0, (-$_input_number_9_1))
	output_number(11, 1, $_input_number_9_2)
	output_number(4, 0, $_input_number_9_1)
	output_number(10, 0, (-$_input_number_9_1))
