class_name TodoNode extends GraphNode

enum NodeTypes 
{
    FOLDER,
    COMMENT,
    TASK
}

@export var node_type : NodeTypes
var model_id : String

func _ready() -> void:
    pass

func load(_data : Dictionary):
    pass
