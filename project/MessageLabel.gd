extends RichTextLabel
var text_temp: String
var bb_style: String
var has_text_changed: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	self["theme_override_colors/font_outline_color"]
	bb_style = "[center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = Game.show_player_msg
	if Game.show_player_msg:
		if Game.gems_collected == 1:
			text_temp = bb_style + "You can now Double Jump!!"
		elif Game.gems_collected == 2:
			text_temp = bb_style + "Jumps now do Damage!!"
		elif Game.gems_collected == 3:
			text_temp = bb_style + "Hold W to Float!!"
		elif Game.gems_collected == 4:
			text_temp = bb_style + "Left Click while Floating to Fly!!"
		else:
			Game.show_player_msg = false
		text = text_temp
