extends Area2D

@export var auto_rotation_speed : float = 15
@export var rotate_multiplier : int = -1
@export var manual_rotation : float = 7
@export var can_select: bool = true

var is_locked = false

var lockpin_locked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("lamelles")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_locked = Input.is_action_pressed("ui_ctrl")
	if !is_locked and !lockpin_locked:
		rotation_degrees += rotate_multiplier * delta * auto_rotation_speed
	
func _input(event):
	if lockpin_locked:
		return
	
	if event.is_action_pressed("ui_scroll_up"):
		rotation_degrees += manual_rotation
	elif event.is_action_pressed("ui_scroll_down"):
		rotation_degrees -= manual_rotation
	
		
	if event.is_action_pressed("ui_esc"):
		get_tree().quit()
		
func lock():
	lockpin_locked = true
