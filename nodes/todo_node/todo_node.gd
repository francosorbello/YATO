class_name TodoNode extends GraphNode

enum NodeTypes 
{
    FOLDER,
    COMMENT,
    TASK
}

@export var node_type : NodeTypes

func _ready() -> void:
    pass

func load(_data : Dictionary):
    pass
