extends "res://hud/Hud.gd"

func getTuneables():
	var res = .getTuneables()
	if res.has("TUNE_XENON_BURN"):
		res.erase("TUNE_XENON_BURN")
	return res
