extends ScrollContainer

class_name DR_ScrollContainer

export var rigidity : float = 1;
export var moveScale : float = 1;

var sysX = {last = null, residuel = 0, amp = 0, ampCount = 0};
var sysY = {last = null, residuel = 0, amp = 0, ampCount = 0};
var draging = false;

var globalRect : Rect2; 

func _ready():
	globalRect = get_global_rect();
	
func _input(event):
	
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		if event.is_pressed():
			draging = true;
			sysY.residuel = 0;
			sysY.residuel = 0;
		else:
			draging = false;
			
			if sysY.ampCount:
				sysY.residuel = sysY.amp / sysY.ampCount;
				sysY.ampCount = 0;
				sysY.amp = 0;
				
			if sysX.ampCount:
				sysX.residuel = sysX.amp / sysX.ampCount;
				sysX.ampCount = 0;
				sysX.amp = 0;

	if draging == false:
		sysY.last = null;
		sysX.last = null;
		return;
		
	if event is InputEventMouseMotion :
		if globalRect.has_point(event.position):
			var y = event.position.y;
			if sysY.last != null:
				var delta = (sysY.last - y) * moveScale;
				scroll_vertical += delta;
				sysY.amp += delta;
				sysY.ampCount += 1;
			sysY.last = y;
			
			var x = event.position.x;
			if sysX.last != null:
				var delta = (sysX.last - y) * moveScale;
				scroll_vertical += delta;
				sysX.amp += delta;
				sysX.ampCount += 1;
			sysX.last = y;

func _process(delta):
	var r = max(0, rigidity);
	
	var dX = sysX.residuel * r * delta;
	if dX > abs(sysX.residuel):
		sysX.residuel = 0;
	else:
		sysX.residuel -= sysX.residuel * r * delta;
	scroll_horizontal += sysX.residuel;
		
	var dY = sysY.residuel * r * delta;
	if dY > abs(sysY.residuel):
		sysY.residuel = 0;
	else:
		sysY.residuel -= sysY.residuel * r * delta;
	scroll_vertical += sysY.residuel;

