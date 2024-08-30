extends Node

const PARENT_FOLDER_UUID : String = "0"
var current_folder_node : FolderModel
var save_path = "res://tests/save.res"
var quick_save_path = ""

enum ButtonSelect
{
    DEFAULT,
    COMMENT,
    FOLDER,
    TASK,
    CODE,
    NEW,
    LOAD,
    SAVE,
    QUICK_SAVE,
}

enum NodeType
{
    FOLDER,
    COMMENT,
    TASK,
    CODE,
    IMAGE
}

func _ready():
    if current_folder_node == null:
        current_folder_node = get_folder_db().add_root_folder()

func get_comment_db() -> TodoNodeDB:
    return $DB/CommentDB

func get_folder_db() -> TodoNodeDB:
    return $DB/FolderDB

func get_connection_db() -> TodoNodeDB:
    return $DB/ConnectionDB

func get_task_db() -> TodoNodeDB:
    return $DB/TaskDB

func get_task_item_db() -> TodoNodeDB:
    return $DB/TaskItemDB

func get_image_db() -> ImageDB:
    return $DB/ImageDB

func get_code_db() -> CodeDB:
    return $DB/CodeDB