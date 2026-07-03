extends "res://enceladus/DiveTarget.gd"

onready var transitTimeValue = get_node("VBoxContainer2/HBoxContainer/MarginContainer/PanelContainer/VBoxContainer/GridContainer/TransitTimeValue")
onready var xenonSlider = get_node("VBoxContainer2/HBoxContainer/MarginContainer/PanelContainer/VBoxContainer/GridContainer/XenonSlider")
onready var xenonValue = get_node("VBoxContainer2/HBoxContainer/MarginContainer/PanelContainer/VBoxContainer/GridContainer/XenonValue")

func _ready():
	var ship = CurrentGame.getPlayerShip()
	if ship:
		if not ship.layerHudName or ship.layerHudName == "":
			ship.layerHudName = "Hud"
		var val = ship.getTunedValue(ship.layerHudName, "TUNE_XENON_BURN", 100)
		xenonSlider.value = val
		xenonValue.text = "%d" % val
		
	xenonSlider.connect("value_changed", self, "_on_XenonSlider_value_changed")
	computePrices()

func computePrices():
	var ship = CurrentGame.getPlayerShip()
	if ship:
		if not ship.layerHudName or ship.layerHudName == "":
			ship.layerHudName = "Hud"
	var res = .computePrices()
	if ship and transitTimeValue:
		var transitTime = ship.getInterlunarTransitTime()
		var hours = int(round(transitTime / 3600.0))
		transitTimeValue.text = "%d" % hours
	return res

func _on_XenonSlider_value_changed(val):
	xenonValue.text = "%d" % val
	var ship = CurrentGame.getPlayerShip()
	if ship:
		if not ship.layerHudName or ship.layerHudName == "":
			ship.layerHudName = "Hud"
		ship.setTunedValue(ship.layerHudName, "TUNE_XENON_BURN", val)
	computePrices()
