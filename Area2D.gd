extends Area2D



func _on_body_entered(body):
	if body.is_in_group("player"):
		colet(body)

func colet(body):
	queue_free() 
	body.wallet()
