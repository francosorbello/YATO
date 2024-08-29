extends NodeView

## Called when adding a new code from UI
func handle_new_code(graph_center : Vector2):
   
    # add code to model
    var center = graph_center
    var new_code = get_node("%CodeController").add_code(center)
   
    if(new_code == null):
        return

    add_code_to_view(new_code)

## Adds a code to the view, based on their model
func add_code_to_view(new_code : CodeModel):
# instantiate code
    var code_instance : TodoNode = node_scene.instantiate()
    code_instance.code_changed.connect(_handle_code_change)
    code_instance.moved.connect(_handle_code_dragged)
    code_instance.node_resized.connect(_handle_code_resized)

    code_instance.model_id = new_code.uuid
    if (new_code.code != ""):
        code_instance.set_text(new_code.code)
    code_instance.position_offset.x = new_code.position.x
    code_instance.position_offset.y = new_code.position.y
    if new_code.size != Vector2.ZERO:
        code_instance.size = new_code.size

    graph.add_child(code_instance)


## Get codes from db and load them into view
func load_nodes_from_folder(folder_id : String):
    var codes = get_node("%CodeController").get_nodes_from_folder(folder_id)
    for comm in codes:
        add_code_to_view(comm) 

## Called when a code changes their text
func _handle_code_change(id : String, n_code : String):
    get_node("%CodeController").update_code_text(id,n_code)

## Called when a code is dragged
func _handle_code_dragged(id : String, new_pos : Vector2):
    get_node("%CodeController").update_code_position(id,new_pos)

## Event system callback
func _handle_global_events(event, _msg : Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        # load_codes_from_save()
        load_nodes_from_folder(GlobalData.current_folder_node.uuid)
    
    if event == GlobalEventSystem.GameEvent.GE_FOLDER_OPENED:
        load_nodes_from_folder(_msg.folder_id)

func _handle_code_resized(id : String, new_size : Vector2):
    get_node("%CodeController").resize(id,new_size)
