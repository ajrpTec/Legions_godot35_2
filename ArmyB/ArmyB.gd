extends Sprite

class_name ArmyB

export var soldierScene : PackedScene;
export var debugDrawing : bool	= true;
export var userControled : bool = false;
export var armyColor : Color 	= Color.black

export var king_code : int		= 0

var formation : Formation		= Formation.new();
var destination : Vector2		= global_position
var soldier_list 				= []

func _ready():	
	destination = global_position
	formation._create_new_formation(rotation,global_position);
	for p in formation.pos_list:
		var s : Soldier = soldierScene.instance()
		s.connect("hit",self,"hitBody")
		s.king_code = king_code
		s.position = p.rotated(rotation); 
		# Ovenfor : jeg forstår ikke det er nødvendigt at rotere positionen her ??
		# det burde være muligt at gøre i formation klassen - men det virker ikke for mig...
		soldier_list.append(s);
		add_child(s);
		pass
	pass
	

func hitBody(this_body,other_body):
	if other_body is Soldier and other_body.king_code != this_body.king_code:
		# der er 50% chance for at other_body dør og 50% chance for at this_body dør
		# fjern også den døde fra listen
		if randf() > 0.5:
			this_body.queue_free()
			soldier_list.erase(this_body)
	
	pass
	
		
func setDestination(new_destination : Vector2):
		destination = new_destination;
		pass

func _process(delta):
	for i in range(0,soldier_list.size()):
		soldier_list[i].moveToDestination(formation.pos_list[i]+formation.global_position)
	formation._moveAndTurnTo(destination)
	update();
	
func _draw():
	if not debugDrawing : return;
	draw_circle(to_local(formation.global_position),80,Color(0,1,0,0.1))
	draw_circle(to_local(destination),5,Color.red)
	#draw_line(to_local(formation.global_position), to_local(formation.global_position + formation.direction*100),Color.red)
	#for p in formation.pos_list:
	#	draw_circle(to_local(formation.global_position + p),4,Color.black);
	pass
	
func _select_army_using_mouse_position():
	var distToFormationCenter : Vector2 = get_global_mouse_position() - formation.global_position;
	if distToFormationCenter.length() < 120:
		debugDrawing 	= !debugDrawing;
		userControled	= !userControled;
		return userControled
	else:
		return false
		
func _deselect():
	debugDrawing	= false;
	userControled	= false;
