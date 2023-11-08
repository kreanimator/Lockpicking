extends Area2D

@export var lockpick_speed : float = 50
var lockpick_speed_slowed : float = lockpick_speed/3


const LAMELLE_LAYER = 1024
const LOCK_LAYER = 4096
const MAIN_LOCK_LAYER = 8192

var move = false
# Called when the node enters the scene tree for the first time.
func _ready():
	%lockpick_animation.play("spawn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = lockpick_speed
	
	if move:
		if Input.is_action_pressed("right_click"):
			speed = lockpick_speed_slowed
			global_position.x -= speed * delta
		else:
			global_position.x -= speed * delta

			
func _input(event):
	if event.is_action_pressed("left_click"):
		move =! move
		


func _on_pin_area_entered(area):
	if area.collision_layer == LAMELLE_LAYER:
		print("fuck")
		move = false
		get_tree().call_group("lamelles","lock")
		get_tree().reload_current_scene()
	elif area.collision_layer == LOCK_LAYER:
		area.get_parent().lock()
	elif area.collision_layer == MAIN_LOCK_LAYER:
		print("Unlocked")
		move = false
		get_tree().call_group("lamelles","lock")
		get_tree().quit()
