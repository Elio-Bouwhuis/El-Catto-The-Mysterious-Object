extends CharacterBody2D

var health = 5
const walk_speed = 1
var hitTime : int = 3
var canHit = true
var canSee = null

@onready var timer = get_node("Timer")
@onready var player = get_node('/root/GameLevel/PlayerCat')


func _ready():
	pass


func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()


func _physics_process(delta):
	if canSee:
		if is_instance_valid(player):
			var direction = (player.position - position).normalized()
			velocity = direction * walk_speed
			#move_and_slide()
			var collision_info = move_and_collide(velocity)
			if collision_info:
				var playerCollide = collision_info.get_collider()
				if playerCollide.is_in_group("player") && canHit:
					playerCollide.die()
					canHit = false
					timer.start(hitTime)


func _on_timer_timeout():
	canHit = true


func _on_area_2d_body_entered(body):
	canSee = body
