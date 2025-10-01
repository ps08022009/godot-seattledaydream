# Flag.gd
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("default")
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://WinPage.tscn")
