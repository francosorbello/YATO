extends Node

func handle_connection_request(graph : GraphEdit, from_node:StringName, from_port:int, to_node:StringName, to_port:int):
    var from_node_id = 0
    var to_node_id = 0
    for child in graph.get_children():
        if child is TodoNode:
            if child.name == from_node:
                from_node_id = child.model_id
            if child.name == to_node:
                to_node_id = child.model_id
    
    if from_node_id == to_node_id:
        push_error("Connecting with same id")
        return
    
    var data = {
        "from_node_id": from_node_id,
        "from_port" : from_port,
        "to_node_id" : to_node_id,
        "to_port": to_port
    }
    var connection = GlobalData.get_connection_db().add(GlobalData.current_folder_node.uuid,data)
    if connection != null:
        graph.connect_node(from_node,from_port,to_node,to_port);

func delete_connections(id : String):

    GlobalData.get_connection_db().delete(id)
    pass

func handle_disconnect_request(graph : GraphEdit, from_node:StringName, from_port:int, to_node:StringName, to_port:int):
    var from_node_id = 0
    var to_node_id = 0
    for child in graph.get_children():
        if child is TodoNode:
            if child.name == from_node:
                from_node_id = child.model_id
            if child.name == to_node:
                to_node_id = child.model_id
    
    if from_node_id == to_node_id:
        push_error("Connecting with same id")
        return
    var err = GlobalData.get_connection_db().delete_from_disconnect(from_node_id,to_node_id)
    if err == OK:
        graph.disconnect_node(from_node,from_port,to_node,to_port)

func get_nodes_from_folder(folder_id : String) -> Array:
    return GlobalData.get_connection_db().get_nodes_from_folder(folder_id)

func get_nodes_connected_from(id : String,port : int) -> Array:
    return GlobalData.get_connection_db().get_nodes_connected_from(id, port)
