extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true
	pass # Replace with function body.

func _physics_process(_delta) -> void:
	if !emitting:
		time -= 1
		if time <=0:
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
