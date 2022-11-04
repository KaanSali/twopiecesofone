extends Area2D

class_name DeathBlock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(body:Player):
	await Fade.fade_out(0.4,Color.BLACK,"Diamond").finished
	body.global_position = body.spawn_point.global_position
	Fade.fade_in(0.4,Color.BLACK,"Diamond")
