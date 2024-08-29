extends Node
## Manages db operations, like saving and loading

var comment_db
var folder_db
var connection_db
var task_db
var task_item_db
var image_db : ImageDB
var code_db : CodeDB

func _ready() -> void:
    comment_db = GlobalData.get_comment_db()
    folder_db = GlobalData.get_folder_db()
    connection_db = GlobalData.get_connection_db()
    task_db = GlobalData.get_task_db()
    task_item_db = GlobalData.get_task_item_db()
    image_db = GlobalData.get_image_db()
    code_db = GlobalData.get_code_db()

func delete_folder(id : String) -> FolderModel:
    var deleted_folder = folder_db.delete(id)
    task_db.delete_from_folder(id)
    comment_db.delete_from_folder(id)
    connection_db.delete_from_folder(id)
    folder_db.delete_from_folder(id)
    image_db.delete_from_folder(id)
    code_db.delete_from_folder(id)
    
    return deleted_folder

func delete_all_from_folder(id : String):
    # for a folder inside a folder, delete all inside
    var child_folders = folder_db.get_nodes_from_folder(id)
    if(child_folders.size() > 0):
        for folder in child_folders:
            delete_all_from_folder(folder.uuid)

    delete_folder(id)

## Save the project
func save(save_path : String):
    var comments = comment_db.save()
    var folders = folder_db.save()
    var connections = connection_db.save()
    var tasks = task_db.save()
    var task_items = task_item_db.save()
    var images = image_db.save()
    var codes = code_db.save()

    var project_save_file = ProjectSaveData.new()
    project_save_file.comments = comments
    project_save_file.folders = folders
    project_save_file.connections = connections
    project_save_file.tasks = tasks
    project_save_file.task_items = task_items
    project_save_file.images = images
    project_save_file.codes = codes

    var status = ResourceSaver.save(project_save_file,save_path)
    if status != OK:
        push_error("Error trying to save")
        return
    
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_SAVED)

## Load a project
func load(load_path : String) -> ProjectSaveData:
    # clear databases 
    clear()

    # load databases with data from save
    var project = ResourceLoader.load(load_path) as ProjectSaveData
    if project == null:
        return null

    comment_db.load(project.comments)
    folder_db.load(project.folders)
    connection_db.load(project.connections)
    task_db.load(project.tasks)
    task_item_db.load(project.task_items)
    image_db.load(project.images)
    code_db.load(project.codes)

    # global event so the ui updates
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_LOADED,{"project":project})
    return project

func clear():
    comment_db.clear()
    folder_db.clear()
    task_db.clear()
    connection_db.clear()
    task_item_db.clear()
    image_db.clear()
    code_db.clear()