extends Panel
@onready var audio_stream_player = $"../AudioStreamPlayer"
@onready var label = $Label
const MUSICAL_NOTE = preload("res://MusicalNote.tscn")
var note_time = -1
var player_time = -1
@onready var spawner = $Spawner

var list_notes = [4000000, 4800000, 6000000, 6800000, 7600000, 8400000]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	
	draw_line(Vector2(0, 20),Vector2(600, 20),Color.AZURE,2.0)
	
	draw_line(Vector2(300, 0), Vector2(300, 15), Color.RED, 1.0)

func _physics_process(delta):
	#label.set_text(str(Time.get_ticks_usec()))
	var time_tick = Time.get_ticks_usec()
	if len(list_notes) > 0:
		if time_tick > list_notes[0]:
			var new_note = MUSICAL_NOTE.instantiate()
			new_note.position = spawner.position
			add_child(new_note)
			list_notes.pop_front()
	if Input.is_action_just_pressed("ui_accept"):
		player_time = Time.get_ticks_usec()
		if note_time > 0:
			print(player_time - note_time)
			note_time = -1
			player_time = -1

func _on_area_2d_body_entered(body):
	if body.is_in_group("Note"):
		audio_stream_player.play()
		note_time = Time.get_ticks_usec()     
		if player_time > 0:
			print(note_time - player_time)
			note_time = -1
			player_time = -1


func _on_area_out_body_entered(body):
	if body.is_in_group("Note"):
		body.queue_free()
