extends TodoNodeDB

func add(folder_id : String, data: Dictionary):
    var new_connection = ConnectionModel.new()
    new_connection.folder_uuid = folder_id
    var err = verify_data(data)
    if err == OK:
        new_connection.from_node_id = data.from_node_id
        new_connection.from_port = data.from_port
        new_connection.to_node_id = data.to_node_id
        new_connection.to_port = data.to_port
        nodes.append(new_connection)
        return new_connection
    return null

func verify_data(_data : Dictionary) -> Error:
    return OK

func delete(id : String):
    var new_nodes = nodes.filter(func(item : ConnectionModel): return item.from_node_id != id and item.to_node_id != id)
    nodes = new_nodes

func delete_from_disconnect(from_id, to_id):
    var i = 0
    for node : ConnectionModel in nodes:
        if node.from_node_id == from_id and node.to_node_id == to_id:
            nodes.remove_at(i)
            return OK
    return FAILED