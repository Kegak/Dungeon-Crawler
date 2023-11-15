extends CharacterBody2D
#https://www.youtube.com/watch?v=k066qVZB8_8&ab_channel=JohnLayton
#for a song idea
@export var endPoint: Marker2D
@export var speed = 20
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition 
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
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
