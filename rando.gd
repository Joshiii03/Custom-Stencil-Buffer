extends Node2D

var games = ["Stray", "The Darkest Files", "Reka", "Citizeen SLeeper"]
#
func _input(event):
	if event.is_action_pressed("ui_accept"):
		print(games.pick_random())
		#var i = RandomNumberGenerator.new()
		#print(i.randi_range(1, 4))
