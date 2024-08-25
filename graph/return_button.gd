extends Button


var folder_queue = []

signal return_to_folder(id : String)

func _ready():

    GlobalEventSystem.suscribe(self,"_handle_global_events")

func _handle_global_events(event, data):
    if event == GlobalEventSystem.GameEvent.GE_FOLDER_OPENED:
        if not folder_queue.has(data.folder_id) and data.folder_id != GlobalData.PARENT_FOLDER_UUID:
            folder_queue.append(data.folder_id) 

    if (event == GlobalEventSystem.GameEvent.GE_LOADED):
        folder_queue.clear()


func _on_pressed() -> void:
    if len(folder_queue) > 1:
        folder_queue.pop_back()
        return_to_folder.emit(folder_queue[len(folder_queue)-1])
    else:
        folder_queue.resize(0)
        return_to_folder.emit(GlobalData.PARENT_FOLDER_UUID)


func _process(_delta: float) -> void:
    disabled = len(folder_queue) <= 0