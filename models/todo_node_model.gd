class_name TodoNodeModel extends Object

var position : Vector2
var uuid : String
var folder_uuid : String = "-1"
var size : Vector2


func _init():
    uuid = UUIDGenerator.generate_uuid()

