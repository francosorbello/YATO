extends Node

@export var task_scene : PackedScene
@export var graph : GraphEdit

func add_task_to_view(new_task : TaskModel):
    var task_instance = task_scene.instantiate()
    task_instance.model_id = new_task.uuid
    task_instance.position_offset = new_task.position
    
    graph.add_child(task_instance)

func handle_new_task(center : Vector2):
    var new_task = get_node("%TaskController").add_task(center)

    if(new_task != null):
        add_task_to_view(new_task)
    
