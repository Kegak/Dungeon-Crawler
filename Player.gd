extends CharacterBody2D

@export var speed: float = 100
@export var accel: float = 10

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var animations = $AnimationPlayer
@onready var weapon = $Weapons/lightSword
var lastDirection

func _ready():
	weapon.visible = false

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	animation()
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
func animation():
	if velocity.y > 0:
		anim_sprite.play("down")
		lastDirection = "down"
	elif velocity.y < 0:
		anim_sprite.play("up")
		lastDirection = "up"
	elif velocity.x < 0:
		anim_sprite.play("left")
		lastDirection = "left"
	elif velocity.x > 0:
		anim_sprite.play("right")
		lastDirection = "right"
	if (velocity.y == 0) and (velocity.x == 0):
		if lastDirection == "up":
			anim_sprite.play("idle_up")
		elif lastDirection == "down":
			anim_sprite.play("idle_down")
		elif lastDirection == "right":
			anim_sprite.play("idle_right")
		elif lastDirection == "left":
			anim_sprite.play("idle_left")
	
func attack():
	weapon.visible = true
	if lastDirection == "up":
		animations.play("attack_up")
	elif lastDirection == "down":
		animations.play("attack_down")
	elif lastDirection == "right":
		animations.play("attack_right")
	elif lastDirection == "left":
		animations.play("attack_left")
	await animations.animation_finished
	weapon.visible = false
	

func _process(_delta: float) -> void:
	pass

func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		get_tree().change_scene_to_file("res://game_over.tscn")
