extends ItemList

func _ready():
	# Clear the ItemList initially (optional)
	clear()

	# Define the controls for the action platformer game
	var controls = [
		"A",
		"D",
		"SpaceBar",
		"S",
		"W",
		"Left Click"
		# Add more controls as needed...
	]

	# Populate the ItemList with controls
	for control in controls:
		add_item(control, null, false)
		print("items have been added")
