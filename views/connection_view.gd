extends Node

@export var graph : GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

func load_nodes_from_folder(folder_id):
    var connections = get_node("%ConnectionController").get_nodes_from_folder(folder_id)
    for connection in connections:
        var from : StringName = ""
        var to : StringName = ""
        for child in graph.get_children():
            if child is TodoNode:
                if connection.from_node_id == child.model_id:
                    from = child.name
                
                if connection.to_node_id == child.model_id:
                    to = child.name

                if from != "" and to != "":
                    graph.connect_node(from,connection.from_port,to,connection.to_port)
                    break 

## Event system callback
func _handle_global_events(event, _msg : Dictionary):
    await get_tree().create_timer(0.1).timeout
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        # load_comments_from_save()
        load_nodes_from_folder(GlobalData.current_folder_node.uuid)
    
    if event == GlobalEventSystem.GameEvent.GE_FOLDER_OPENED:
        load_nodes_from_folder(_msg.folder_id)

    if event == GlobalEventSystem.GameEvent.GE_TASK_ITEM_DELETED:
        _handle_deleting_task_item(_msg)

func _handle_deleting_task_item(_msg : Dictionary):
    var connections = get_node("%ConnectionController").get_nodes_connected_from(_msg.item.folder_uuid,_msg.slot)
    for conn : ConnectionModel in connections:
        var from_node = ""
        var to_node = ""
        for child in graph.get_children():
            if child is TodoNode:
                if child.model_id == conn.from_node_id:
                    from_node = child.name
                if child.model_id == conn.to_node_id:
                    to_node = child.name
        
        var err = GlobalData.get_connection_db().delete_from_disconnect(conn.from_node_id,conn.to_node_id)
        if err == OK:
            graph.disconnect_node(from_node,conn.from_port,to_node,conn.to_port)