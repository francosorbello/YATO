class_name TodoNodeDB extends Node 

var nodes : Array[TodoNodeModel]

## Adds a node
## folder_id : Secondary key, the id of the folder the node is part of
## data : any other relevant data
func add(_folder_id : String, _data : Dictionary) -> TodoNodeModel:
    return null

## Replace the id of a node with a new one
func replace_id(old_id: String, new_id : String) -> TodoNodeModel:
    var i = get_node_index(old_id)
    nodes[i].uuid = new_id
    return nodes[i]

## Remove a node from the database
func delete(id: String) -> TodoNodeModel:
    var i = get_node_index(id)
    var deleted_node = nodes[i]
    nodes.remove_at(i)
    return deleted_node

func update(_id: String, _data : Dictionary) -> TodoNodeModel:
    if _data.has("size"):
        var i = get_node_index(_id)
        nodes[i].size = _data.size
        return nodes[i]
    return null 

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

func delete_from_folder(folder_id : String) -> TodoNodeModel:
    for node in nodes:
        if node.folder_uuid == folder_id:
            return delete(node.uuid)
    return null

func clear():
    nodes.clear()

func verify_data(data : Dictionary) -> Error:
    if data.has("position"):
        return OK
    return FAILED