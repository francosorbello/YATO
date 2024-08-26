extends Node

@export var task_scene : PackedScene
@export var graph : GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

func add_task_to_view(new_task : TaskModel):
    var task_instance = task_scene.instantiate()
    task_instance.model_id = new_task.uuid
    task_instance.position_offset = new_task.position
    if (new_task.title != ""):
        task_instance.set_task_title(new_task.title)
    task_instance.moved.connect(_handle_task_dragged)
    task_instance.on_title_changed.connect(_handle_task_change)
    task_instance.on_add_item_requested.connect(_hande_add_item)
    
    graph.add_child(task_instance)

func handle_new_task(center : Vector2):
    var new_task = get_node("%TaskController").add_task(center)

    if(new_task != null):
        add_task_to_view(new_task)


## Get tasks from db and load them into view
func load_nodes_from_folder(folder_id : String):
    var tasks = get_node("%TaskController").get_nodes_from_folder(folder_id)
    for task in tasks:
        add_task_to_view(task)
        add_items_to_task(task.uuid)

func add_items_to_task(task_id : String):
    var items = get_node("%TaskItemController").get_items_for_task(task_id)
    for item in items:
        $TaskItemView.add_item_to_task(task_id,item)

func _hande_add_item(id : String):
    $TaskItemView.handle_new_task_item(id)
    
func _handle_task_change(id : String, n_title : String):
    get_node("%TaskController").update_task_title(id,n_title)

func _handle_task_dragged(id : String, new_pos : Vector2):
    get_node("%TaskController").update_task_position(id,new_pos)

func _handle_global_events(event, _msg : Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        load_nodes_from_folder(GlobalData.current_folder_node.uuid)
    
    if event == GlobalEventSystem.GameEvent.GE_FOLDER_OPENED:
        load_nodes_from_folder(_msg.folder_id)