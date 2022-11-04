@tool
extends CharacterBody2D
class_name Player
@export_group("Character Specializers")
@export var character_texture : Texture2D : set = set_character_texture
@export var spawn_point : Node2D : set = set_character_spawn_point
@export_group("Movement Variables")
@export var max_speed := 400.0
@export var gravity_scale := 1.0
@export var fall_scale := 2.0
@export var deaccelerate_time := 0.2 
@export_group("Jump Variables")
@export var jump_speed := 400.0

@onready var collision : CollisionShape2D = $CollisionShape2D

var is_stopped := true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	if not Engine.is_editor_hint():
		process_non_editor(delta)

func process_non_editor(delta:float):
	set_jump()
	set_movement_vector(delta)
	apply_gravity()

func set_movement_vector(delta:float)->void:
	var horizontal_direction : float = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	velocity.x += horizontal_direction * max_speed / 6.0
	if(abs(velocity.x)>max_speed):
		velocity = Vector2(signf(velocity.x)*max_speed,velocity.y)
	if(horizontal_direction == 0 and abs(velocity.x) > 0 and is_stopped != false):
		create_tween().tween_property(self,"velocity:x",0,deaccelerate_time).connect("finished",tween_stopped)
		is_stopped = false
		#velocity = Vector2(0,velocity.y)
	# Map horizontal Limits
	if(global_position.x <= 32.0 and velocity.x < 0.0):
		velocity.x = 0
	
func set_jump()->void:
	if Input.get_action_strength("jump") > 0.0 and is_on_floor() == true:
		velocity += jump_speed * Vector2.UP

func apply_gravity()->void:
	var scale = 1.0
	# Fall Gravity
	if((Input.get_action_strength("jump") == 0.0 and velocity.y < 0.0) or velocity.y > 0.0):
		scale = fall_scale
	else:
		scale = gravity_scale 
	velocity -= jump_speed/18.0 * scale * Vector2.UP

func tween_stopped()->void:
	is_stopped=true

func set_character_texture(value):
	if Engine.is_editor_hint():
		character_texture = value
		$character_texture.set_texture(value)

func set_character_spawn_point(node:Node2D):
	spawn_point = node
	if(is_instance_valid(node)):
		global_position = node.global_position
