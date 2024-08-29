extends Node
class_name NodeView

@export var node_scene : PackedScene
@export var graph :GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

func _handle_global_events(_event, _msg : Dictionary):
    pass