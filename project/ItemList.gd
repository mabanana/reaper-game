extends ItemList

func _ready():
	# Clear the ItemList initially (optional)
	clear()

	# Define the controls for the action platformer game
	var controls = [
		"Move Left:",
		"Move Right",
		"Jump",
		"Fast Fall",
		"Float",
		"Flying Dash"
		# Add more controls as needed...
	]

	# Populate the ItemList with controls
	for control in controls:
		add_item(control, null, false)
		print("items have been added")
