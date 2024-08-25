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

func save() -> ListResource:
    var data = ListResource.new()
    for node : ConnectionModel in nodes:
        var save_data = ConnectionSaveData.new()
        save_data.from_node_id = node.from_node_id
        save_data.from_port = node.from_port
        save_data.to_node_id = node.to_node_id
        save_data.to_port = node.to_port
        save_data.folder_uuid = node.folder_uuid
        save_data.uuid = node.uuid
        data.data.append(save_data)
    return data

func load(connections : ListResource):
    for connection : ConnectionSaveData in connections.data:
        var params = {
            "from_node_id" : connection.from_node_id,
            "from_port" : connection.from_port,
            "to_node_id" : connection.to_node_id,
            "to_port" : connection.to_port
        }
        var new_conn = add(connection.folder_uuid,params)
        replace_id(new_conn.uuid,connection.uuid)

    