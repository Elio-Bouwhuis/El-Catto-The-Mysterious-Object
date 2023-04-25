extends CharacterBody2D

@export var move_speed : float = 1.5
@export var starting_direction : Vector2 = Vector2(0,1)

const bulletPath = preload("res://Characters/bullet.tscn")
const fastBulletPath = preload("res://Characters/fast_bullet.tscn")
const bigBulletPath = preload("res://Characters/big_bullet.tscn")

@onready var HUD = get_node('/root/GameLevel/HUD')

@onready var animation_tree = $AnimationTree

var normalBulletActive = true
var fastBulletActive = false
var bigBulletActive = false

var fastBulletFound = false
var bigBulletFound = false

var health : int = 3
var canAction = true

func _ready():
	animation_tree.set("parameters/Idle/blend_position", starting_direction)
	Input.is_action_just_pressed("normal bullet")


func setMoveOff():
	canAction = false
	
	
func setMoveOn():
	canAction = true


func _physics_process(_delta):
	if canAction:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
		velocity = input_direction * move_speed
		
		#move_and_slide()
		var collision_info = move_and_collide(velocity)
		if collision_info:
			var fastBulletCollide = collision_info.get_collider()
			if fastBulletCollide.is_in_group("fastBullet"):
				fastBulletCollide.destroyMe()
				fastBulletFound = true
			
			var bigBulletCollide = collision_info.get_collider()
			if bigBulletCollide.is_in_group("bigBullet"):
				bigBulletCollide.destroyMe()
				bigBulletFound = true
		
		if Input.is_action_just_pressed("normal bullet"):
			normalBulletActive = true
			fastBulletActive = false
			bigBulletActive = false
		
		if Input.is_action_just_pressed('shoot') && normalBulletActive:
			shoot()
			
		if Input.is_action_just_pressed("fast bullet") && fastBulletFound:
			fastBulletActive = true
			normalBulletActive = false
			bigBulletActive = false
		
		if Input.is_action_just_pressed('shoot') && fastBulletActive:
			fastBullet()
		
		if Input.is_action_just_pressed("big bullet") && bigBulletFound:
			bigBulletActive = true
			normalBulletActive = false
			fastBulletActive = false
		
		if Input.is_action_just_pressed('shoot') && bigBulletActive:
			bigBullet()
				
		$Node2D.look_at(get_global_mouse_position())


func shoot():
	var bullet = bulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	
	bullet.velocityBullet = get_global_mouse_position() - bullet.position


func fastBullet():
	var bullet = fastBulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	
	bullet.velocityBullet = get_global_mouse_position() - bullet.position


func bigBullet():
	var bullet = bigBulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	
	bullet.velocityBullet = get_global_mouse_position() - bullet.position


func die():
	health -= 1
	HUD.updateLives()
	if health == 0:
		queue_free()	
		

func bossDamage():
	health -= 3
	if health == 0:
		queue_free()	
