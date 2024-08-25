extends Node

func save():
    var comments = $CommentDB.save()
    var folders = $FolderDB.save()

    var project_save_file = ProjectSaveData.new()
    project_save_file.comments = comments
    project_save_file.folders = folders

    var status = ResourceSaver.save(project_save_file,GlobalData.save_path)
    if status != OK:
        push_error("Error trying to save")
    pass

func load():
    var project = ResourceLoader.load(GlobalData.save_path) as ProjectSaveData
    $CommentDB.load()
    return project

