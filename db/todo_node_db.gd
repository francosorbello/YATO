class_name TodoNodeDB extends Node 

var nodes : Array[TodoNodeModel]

## Adds a node
## folder_id : Secondary key, the id of the folder the node is part of
## data : any other relevant data
func add(_folder_id : String, _data : Dictionary):
    pass

## Remove a node from the database
func delete(id: String):
    var i = get_node_index(id)
    nodes.remove_at(i)

func update(_id: String, _data : Dictionary):
    pass

## Searches node by id. Null if it doesnt exist
func get_by_id(id : String) -> TodoNodeModel:
    for node in nodes:
        if node.uuid == id:
            return node
    return null

## Returns index of node inside of db, or -1 if it doesnt exist
func get_node_index(id : String) -> int:
    var i : int = 0
    for node in nodes:
        if node.uuid == id:
            return i
        i += 1
    return -1


## Return all nodes from a folder
func get_nodes_from_folder(folder_id : String):
    var folder_nodes = []
    for node in nodes:
        if node.folder_uuid == folder_id:
            folder_nodes.append(node)
    
    return folder_nodes

func clear():
    nodes.clear()

func verify_data(data : Dictionary) -> Error:
    if data.has("position"):
        return OK
    return FAILED 