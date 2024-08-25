extends Object 
class_name TaskItemModel

@export var uuid : String
@export var finished : bool
@export var title : String

func _init():
    uuid = UUIDGenerator.generate_uuid()