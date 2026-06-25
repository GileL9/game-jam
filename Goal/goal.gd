extends Area2D
@export var current_level: int = 1
@export var level_folder_path: String = "res://Levels/"
@export var level_select_scene: String = "res://UI/LevelSelect/LevelSelect.tscn"
@onready var sprite = $Sprite2D
var sad = false
var haptex = preload("res://assets/pciconhappy.png")
var sadtex = preload("res://assets/pciconsad.png")
@onready var asdasd = $AudioStreamPlayer2D
func _on_body_entered(body: Node2D) -> void:
	# 1. Force visual confirmation that the engine registered the hit
	if body.is_in_group("player"):	
		#asdasd.play()
		call_deferred("_test_change")

func _test_change() -> void:
	if sad:
		return
	if current_level % 4 == 0:
		get_tree().change_scene_to_file("res://UI/LevelSelect/LevelSelect.tscn")
	else:
		var next_level_num = current_level + 1
		var next_scene_path = level_folder_path + "Level" + str(next_level_num) + ".tscn"
		
		if ResourceLoader.exists(next_scene_path):
			get_tree().change_scene_to_file(next_scene_path)
		else:
			print("Error: Could not find next level scene at: ", next_scene_path)


func change_icon(icon):
	if icon == "happy":
		sprite.texture = haptex
		sad = false
	elif icon == "sad":
		sprite.texture = sadtex
		sad = true
	
	pass
