extends Node

@export var time_between_clicks : float = 0.3
var first_click : bool = false
var current_time : float = 0

signal double_click

func _process(delta: float) -> void:
    if Input.is_action_just_released("click"):
        if not first_click:
            first_click = true
            current_time = 0
        else:
           if current_time <= time_between_clicks:
               double_click.emit() 
           current_time = 0
           first_click = false 

    current_time += delta