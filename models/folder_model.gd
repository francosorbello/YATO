class_name FolderModel extends TodoNodeModel

var title : String
var nodes : Array[TodoNodeModel]
var connections : Array[ConnectionModel]

func add_todo_node(node : TodoNodeModel):
    if nodes.has(node):
        return null
    else:
        nodes.append(node)
        return node

func get_node_by_id(id : String):
    for node in nodes:
        if node.uuid == id:
            return node

    return null