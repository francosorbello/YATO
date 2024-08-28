extends Button

@export var icons : Array[Texture] = []

var type : int

func set_type(t : int):
    type = t
    match type:
        GlobalData.ButtonSelect.NEW:
            icon = icons[0]
        GlobalData.ButtonSelect.LOAD:
            icon = icons[1]
        GlobalData.ButtonSelect.SAVE:
            icon = icons[2]
        GlobalData.ButtonSelect.QUICK_SAVE:
            icon = icons[3]

func set_hint(hint : String):
    tooltip_text = hint