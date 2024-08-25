extends Node

enum GameEvent
{
    GE_SAVED,
    GE_LOADED,
    GE_FOLDER_OPENED
}

class GESuscriber:
    var owner : Node
    var function_name : String

    func is_valid() -> bool:
        return owner != null and owner.has_method(function_name)
    
    func execute(event, message : Dictionary = {}):
        owner.call_deferred(function_name,event, message)

var suscribers : Array

func suscribe(node : Node, function_name : String):
    var suscriber = GESuscriber.new()
    suscriber.owner = node
    suscriber.function_name = function_name
    
    suscribers.append(suscriber)

func emit(event : GameEvent, message : Dictionary = {}):
    for suscriber : GESuscriber in suscribers:
        if suscriber.is_valid():
            suscriber.execute(event,message)