extends CharacterBody2D

@onready var note_speed = Vector2(-3000,0)

func _physics_process(delta):
	velocity = note_speed * delta

	move_and_slide()
