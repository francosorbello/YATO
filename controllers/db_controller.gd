extends Node
## Manages db operations, like saving and loading

var comment_db
var folder_db
var connection_db
var task_db

func _ready() -> void:
    comment_db = GlobalData.get_comment_db()
    folder_db = GlobalData.get_folder_db()
    connection_db = GlobalData.get_connection_db()

## Save the project
func save():
    var comments = comment_db.save()
    var folders = folder_db.save()
    var connections = connection_db.save()

    var project_save_file = ProjectSaveData.new()
    project_save_file.comments = comments
    project_save_file.folders = folders
    project_save_file.connections = connections

    var status = ResourceSaver.save(project_save_file,GlobalData.save_path)
    if status != OK:
        push_error("Error trying to save")
    
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_SAVED)

## Load a project
func load() -> ProjectSaveData:
    # clear databases 
    comment_db.clear()
    folder_db.clear()

    # load databases with data from save
    var project = ResourceLoader.load(GlobalData.save_path) as ProjectSaveData
    comment_db.load(project.comments)
    folder_db.load(project.folders)
    connection_db.load(project.connections)

    # global event so the ui updates
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_LOADED,{"project":project})
    return project