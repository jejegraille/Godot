extends Node;

class_name DR_SetTimeOut

var time : float;
var callback : FuncRef;

func _init(timeSeconde : float, node : Node, functionName : String):
	time = timeSeconde;
	callback = funcref(node, functionName);
	node.add_child(self);

func _process(delta):
	time -= delta;
	if time <= 0:
		callback.call_func();
		queue_free();
