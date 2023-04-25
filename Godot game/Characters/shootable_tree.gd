extends StaticBody2D

var health = 10

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
