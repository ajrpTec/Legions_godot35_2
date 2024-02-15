class_name Formation

var global_position	= Vector2.ZERO 
var pos_list		= []
var direction		= Vector2.UP 

func _init():
	pass
	
		
func _create_new_formation( new_heading:float , new_global_position:Vector2 ):
	direction 		= direction.rotated(new_heading);
	global_position	= new_global_position;
	for i in range(-2,3):
		for j in range(-2,3):
			var p : Vector2 = Vector2(i*40,j*40);
			pos_list.append(p);
	pass

func _moveAndTurnTo(pos):
	_moveTo(pos)
	_turnTo(global_position - pos)

func _turnTo(new_direction:Vector2):
	var err_a = new_direction.angle_to(direction);	
	if err_a != 0:
		var a = err_a/200;
		for i in range(0,pos_list.size()):
			pos_list[i] = pos_list[i].rotated(a);
		direction = direction.rotated(a);
	pass

func _moveTo(new_global_position:Vector2):
	var err_p = new_global_position - global_position;
	if err_p.length() > 3:
		global_position = global_position + err_p.clamped(1);
