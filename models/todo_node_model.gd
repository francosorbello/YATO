class_name TodoNodeModel extends Object

var position : Vector2
var uuid : String
var folder_uuid : String = "-1"


func _init():
    uuid = UUIDGenerator.generate_uuid()

