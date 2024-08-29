extends Node

@export var image_scene : PackedScene
@export var graph : GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

func add_image_to_view(new_image : ImageModel):
    var image_instance = image_scene.instantiate()
    image_instance.model_id = new_image.uuid
    image_instance.set_image(new_image.image)
    image_instance.position_offset = new_image.position
    if new_image.size != Vector2.ZERO:
        image_instance.size = new_image.size
    
    image_instance.moved.connect(_handle_image_dragged)
    image_instance.node_resized.connect(_handle_image_resized)
    graph.add_child(image_instance)

func _handle_image_dragged(id : String, new_pos : Vector2):
    get_node("%ImageController").update_image_position(id,new_pos)

func _handle_image_resized(id : String, new_size : Vector2):
    get_node("%ImageController").resize(id,new_size)

func _on_short_cut_manager_on_paste_image(image:Image) -> void:
    var image_model = get_node("%ImageController").add_image(graph.get_global_mouse_position(),image)
    add_image_to_view(image_model)

func _handle_global_events(event, _msg : Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        load_nodes_from_folder(GlobalData.current_folder_node.uuid)
    
    if event == GlobalEventSystem.GameEvent.GE_FOLDER_OPENED:
        load_nodes_from_folder(_msg.folder_id)

func load_nodes_from_folder(folder_id : String):
    var images = get_node("%ImageController").get_nodes_from_folder(folder_id)
    for img : ImageModel in images:
        add_image_to_view(img)