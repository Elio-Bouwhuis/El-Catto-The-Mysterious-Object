extends CharacterBody2D

var velocityBullet = Vector2(1,0)
var speed = 400
const damage = 0.75

func _ready():
	pass
	

func _physics_process(delta):
	var collision_info = move_and_collide(velocityBullet.normalized() * delta * speed)
	if collision_info:
		queue_free()
		var enemy = collision_info.get_collider()
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage)
