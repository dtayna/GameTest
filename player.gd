extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var voo = -50
var alive = true
var jumps = 0
var desjumps = 0
var money = 0
var helio = false
var peso = false

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _label_wallet = $Camera2D/CanvasLayer/Label
@onready var _label_die = $Camera2D/Label
@onready var _sprite_helio = $Camera2D/CanvasLayer/Sprite2D2
@onready var _sprite_peso = $Camera2D/CanvasLayer/Sprite2D3

func _physics_process(delta):
	_sprite_helio.visible=helio
	_sprite_peso.visible=peso
	
	var jump = Input.is_action_just_pressed("ui_up")
	var desjump = Input.is_action_just_pressed("ui_down")
	
	if alive:
		_animated_sprite.play("run")
	else:
		_label_die.text = str("Morreu, cara!")
		_animated_sprite.play("die")
		collision_mask = 2
		velocity.y = -200
		
	# Add the gravity.
	if not is_on_floor() and (not helio) or peso:
		velocity.y += gravity * delta
	elif not is_on_floor() and helio and not peso:
		if get_position().y>=100:
			velocity.y += -gravity * delta
		else:
			velocity.y = 0
	
	
		
	if is_on_floor():
		desjumps=0
	
	if jump and is_on_floor() and not helio:
		velocity.y = JUMP_VELOCITY
		jumps=0
	elif jump and jumps<2  and not helio:
		velocity.y = JUMP_VELOCITY
		jumps+=1
	elif jump and is_on_floor() and helio:
		velocity.y = -200
		jumps=0
	
	if desjump and not is_on_floor() and helio:
		velocity.y += 600
		desjumps +=1
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.scale.x = -1
		velocity.x = direction * SPEED
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.scale.x = 1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func damage():
	alive = false
	await get_tree().create_timer(1).timeout 
	visible = false

func wallet():
	if alive:
		money += 1
		_label_wallet.text = str(money)
	
func morehelio():
	#tá com problema da quicadinha
	desjumps=0
	helio=not helio
	velocity.y = -200

func pesocollet():
	peso= true
	#ver como vou descartar depois esse pesinho bu
