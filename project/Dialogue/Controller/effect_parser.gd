class_name DialogueEffectParser

func parse_effect_string(effect: String):
	var split: Array = effect.split(" ")
	if split[0] == "do":
		var method_name = split[1]
		var argument = ""
		if Game.has_method(method_name):
			if len(split) > 2:
				var type = split[2]
				argument = split[3]
				argument = parse_type(type.to_lower(), argument)
				Game.call(method_name, argument)
			else:
				Game.call(method_name)
			print("effect calling function %s(%s)" %
			[method_name, argument])
	elif split[0] == "set":
		var var_name = split[1]
		var type = split[2]
		var value = split[3]
		print("effect setting %s: %s = %s" %
		[var_name, type, value])
		value = parse_type(type, value)
		Game.set(var_name, value)
		prints("effect set:", var_name, value, Game.get(var_name))

func parse_type(type, value):
	match type:
			"bool":
				if value == "true":
					return true
				elif value == "false":
					return false
			"int":
				return int(value)
			"float":
				return float(value)
			"string":
				return value
			_:
				pass
				
