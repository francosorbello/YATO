extends Node
## Manages db operations, like saving and loading

## Save the project
func save():
    var comments = GlobalData.get_comment_db().save()
    var folders = GlobalData.get_folder_db().save()

    var project_save_file = ProjectSaveData.new()
    project_save_file.comments = comments
    project_save_file.folders = folders

    var status = ResourceSaver.save(project_save_file,GlobalData.save_path)
    if status != OK:
        push_error("Error trying to save")
    
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_SAVED)

## Load a project
func load():
    # clear databases 
    GlobalData.get_comment_db().clear()
    GlobalData.get_folder_db().clear()

    # load databases with data from save
    var project = ResourceLoader.load(GlobalData.save_path) as ProjectSaveData
    GlobalData.get_comment_db().load(project.comments)
    GlobalData.get_folder_db().load(project.folders)

    # global event so the ui updates
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_LOADED,{"project":project})
    return project