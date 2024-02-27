extends Node2D

class_name Main

var army_list_king1 = [];
var army_list_king2 = [];

func _ready():
	army_list_king1 = $King1.get_children()
	army_list_king2 = $King2.get_children()
	pass


func _process(delta):
#	var attacker1 : ArmyB 	= army_list_king2[0];
#	var wayPoint : Vector2	= army_list_king1[0].formation.global_position;
#	attacker1.setDestination(wayPoint)
	pass


func _input(event):
	# HVIS 1 TRYKKES
	if Input.is_action_just_pressed("1"):
		for a in army_list_king1:
			if a.userControled :
				a.formation._init_consentrate_formation()
				return
	
	# HVIS 2 TRYKKES
	if Input.is_action_just_pressed("2"):
		for a in army_list_king1:
			if a.userControled :
				a.formation._init_square_formation()
				return


	# VENSTRE MUSEKLIK
	if Input.is_action_just_pressed("mouseLeft"):
		
		var armySelected = -1
		
		# Kontroller om musen vælger en af hærene fra KING1
		for i in range(0,army_list_king1.size()):
			if army_list_king1[i]._select_army_using_mouse_position():
				armySelected = i
				break
		
		# En hær er valgt : 		Alle andre hære "deselectes"
		if armySelected != -1:
			for i in range(0,army_list_king1.size()):
				if i != armySelected:
					army_list_king1[i]._deselect();
		
		# En hør er IKKE valgt :	Den hør der er "userControlled" flyttes til musens position  
		if armySelected == -1:
			for a in army_list_king1:
				if a.userControled :
					a.setDestination(get_global_mouse_position());
					return
		
	pass


