extends CharacterBody2D

@export var speed = 30
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D

var startPosition
var endPosition
var seen

func _ready():
	startPosition = position
	seen = false
	var player = get_parent().get_parent().get_node("TileMap/Player")
	
	endPosition = startPosition
	
func changeDirection():
	var tempEnd = endPosition 
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var player = get_parent().get_parent().get_node("TileMap/Player")
	if seen == true:
		endPosition = player.position
	var moveDirection = endPosition - position
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	animations.play("default")
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()




func _on_hit_box_area_entered(area):
	if area.name == "lightSword":
		var sword = area.get_parent()
		if sword.visible == true:
			#print_debug("Hit\n")
			queue_free()


func _on_sight_area_entered(area):
	if area.name == "hurtBox":
		seen = true
		var player = get_parent().get_parent().get_node("TileMap/Player")
		endPosition = player.position
	
