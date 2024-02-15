extends RigidBody2D

class_name Soldier

var destination : Vector2;
var direction	: Vector2;

var debug_drawing = false;

var king_code : int = 0

signal hit(this_body,other_body)

func _ready():
	destination = global_position
	pass

func _process(delta):
	if debug_drawing : update()

func moveToDestination(dest):
	destination = dest;
	direction = destination - global_position;
	apply_central_impulse(direction.clamped(5));
	

func _draw():
	if not debug_drawing : return;
	draw_circle(to_local(destination),5,Color.blue)
	draw_line(Vector2.ZERO,direction.rotated(-rotation),Color.black,1)


func _on_Soldier_body_entered(body):
	emit_signal("hit",self,body)
	pass # Replace with function body.
