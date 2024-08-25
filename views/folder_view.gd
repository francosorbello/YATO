extends Node

@export var folder_scene : PackedScene
@export var graph : GraphEdit
func handle_new_folder(pos : Vector2):
    var new_folder = GlobalData.get_folder_db().add(GlobalData.current_folder_node.uuid,{"position":pos})

    var folder_node = folder_scene.instantiate()
    folder_node.position_offset = pos
    folder_node.folder_id = new_folder.uuid
    folder_node.open_folder.connect(_on_folder_open)

    graph.add_child(folder_node)

func _on_folder_open(id : String):
    print("open folder "+id)
    pass