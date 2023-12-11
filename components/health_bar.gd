extends Label3D
class_name HealthBar


@export  var show_percent        : bool            = false
@export  var width_in_characters : int             = 10
@onready var half_width_in_chars : int             = width_in_characters/2 - 2
var         health_component     : HealthComponent
# Called when the node enters the scene tree for the first time.
func _ready():
	var parent : Node = get_parent()
	if !parent.has_node("HealthComponent"): return
	var hlth_cmpnt : Node = parent.get_node("HealthComponent")
	if !(hlth_cmpnt is HealthComponent): return
	health_component = hlth_cmpnt
	health_component.changed.connect(update_health.bind())
	update_health()


func update_health():
	var scalar_health     : float = health_component.health/health_component.MAX_HEALTH
	var percentage_health : float = scalar_health * 100
	var health_bar_width  : int   = int(width_in_characters * scalar_health)
	var health_bar_text   : String = "["
	#health_bar_text.lpad(health_bar_width,"#")
	#health_bar_text.lpad(1,"[")
	#health_bar_text.rpad(width_in_characters-health_bar_width,"-")
	#health_bar_text.rpad(1,"]")
	for i in range(health_bar_width):
		health_bar_text += "#"
	for i in range(width_in_characters-health_bar_width):
		health_bar_text += "-"
	health_bar_text += "]"
	text = health_bar_text
	if !show_percent: return
	text += "%3.0f" % percentage_health + "%"
