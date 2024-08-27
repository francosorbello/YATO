extends Node

@export var folder_scene : PackedScene
@export var graph : GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

func handle_new_folder(pos : Vector2):
    var new_folder = GlobalData.get_folder_db().add(GlobalData.current_folder_node.uuid,{"position":pos}) 

    add_folder_to_view(new_folder)

## Adds a folder to the graph
func add_folder_to_view(new_folder : FolderModel):
    var folder_node = folder_scene.instantiate()
    folder_node.position_offset = new_folder.position
    folder_node.model_id = new_folder.uuid
    if new_folder.title != "":
        folder_node.set_new_title(new_folder.title)
    folder_node.open_folder.connect(on_folder_open)
    folder_node.moved.connect(_handle_folder_dragged)
    folder_node.title_changed.connect(_handle_folder_title_changed)

    graph.add_child(folder_node)

## Called when a folder is opened from UI
func on_folder_open(id : String):
    # clear the graph
    graph.clear()

    # replace current folder
    GlobalData.current_folder_node = GlobalData.get_folder_db().get_by_id(id)

    # add folder nodes
    var folders = GlobalData.get_folder_db().get_nodes_from_folder(id)
    for folder in folders:
        if folder.uuid == GlobalData.PARENT_FOLDER_UUID:
            continue
        add_folder_to_view(folder)

    # global event
    
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_FOLDER_OPENED,{"folder_id":id})

## Called when a folder node is moved
func _handle_folder_dragged(id : String, new_pos : Vector2):
    get_node("%FolderController").update_folder_position(id, new_pos)

func _handle_folder_title_changed(id : String, new_title : String):
    get_node("%FolderController").update_folder_title(id, new_title)

## Loads folder nodes belonging to another folder
func load_nodes_from_folder(folder_id):
    var folders = get_node("%FolderController").get_nodes_from_folder(folder_id)
    for folder in folders:
        add_folder_to_view(folder)

func _handle_global_events(event, _msg : Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        # load_comments_from_save()
        load_nodes_from_folder(GlobalData.current_folder_node.uuid)