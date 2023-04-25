extends CharacterBody2D

var health = 200
const walk_speed = 1.5
var timeShoot : int = 3
var canSee = null;

@onready var timer = get_node("Timer")
@onready var player = get_node('/root/GameLevel/PlayerCat')
@onready var cowBoss = get_node('/root/GameLevel/bossCow')
@onready var HUD = get_node('/root/GameLevel/HUD')

const bigBulletPath = preload("res://Characters/big_bullet.tscn")


func _ready():
	pass
	timer.start(timeShoot)


func take_damage(damage):
	health -= damage
	if health <= 0:
		HUD.showEnd()
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
				if playerCollide.is_in_group("player"):
					playerCollide.bossDamage()


func bigBullet():
	if canSee:
		if is_instance_valid(player):
			$Node2D.look_at(player.position)
			var direction = (player.position - position).normalized()
			velocity = direction * walk_speed
			#move_and_slide()
			var collision_info = move_and_collide(velocity)
			var bullet = bigBulletPath.instantiate()
			
			get_parent().add_child(bullet)
			bullet.position = $Node2D/Marker2D.global_position
			
			bullet.velocityBullet = direction * walk_speed


func _on_timer_timeout():
	bigBullet()


func _on_area_2d_body_entered(body):
	canSee = body
