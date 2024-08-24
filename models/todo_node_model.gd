class_name TodoNodeModel extends Object

var position : Vector2
var uuid : String
var folder_uuid : String = "-1"


func _init():
    uuid = UUIDGenerator.generate_uuid()

func set_folder(folder_id):
    folder_uuid = folder_id

func serialize():
    pass

func save():
    pass

func load():
    pass

func to_json():
    var data = {
        "x": position.x,
        "y": position.y,

    }