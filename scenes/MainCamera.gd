extends Camera2D

@export var TrackTarget : Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(TrackTarget):
		global_position = TrackTarget.global_position
