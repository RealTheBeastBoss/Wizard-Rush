extends CanvasLayer

@onready var heart = $Heart
@onready var mana_bar = $ValueBar

func _ready():
	GameManager.added_mana.connect(update_mana)
	GameManager.damaged_player.connect(update_health)

func update_mana():
	mana_bar.value = GameManager.current_mana

func update_health():
	if heart.frame == 0:
		heart.frame = 3
