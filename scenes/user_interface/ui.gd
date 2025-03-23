extends CanvasLayer

#colors
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9,0,0,1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $Health/MarginContainer/TextureProgressBar

func _ready() -> void:
	Globals.connect("stats_change", update_stats_ui)
	update_laser_ui()
	update_grenade_ui()
	update_health_ui()
	
func update_laser_ui() -> void:
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)
	

func update_grenade_ui() -> void:
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_color(amount:int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else: 
		label.modulate = green
		icon.modulate = green
		
func update_health_ui():
	health_bar.value = Globals.health
	
func update_stats_ui():
	update_laser_ui()
	update_grenade_ui()
	update_health_ui()
	
