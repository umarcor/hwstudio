extends Tabs


onready var backend_type : OptionButton = $Scroll/Sections/Backend/Type/OptionButton;


func _ready():
	for k in range(Data.backends.size()):
		backend_type.add_item(Data.backends[k], k);
