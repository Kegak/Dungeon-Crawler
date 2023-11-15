extends CharacterBody2D





func _on_kill_box_area_entered(area):
	if area.name == "lightSword":
		var sword = area.get_parent()
		if sword.visible == true:
			#print_debug("Hit\n")
			get_tree().change_scene_to_file("res://you_win.tscn")
