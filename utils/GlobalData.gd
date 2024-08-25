extends Node

const PARENT_FOLDER_UUID : String = "0"
var current_folder_node : FolderModel
var save_path = "res://tests/save.res"

func _ready():
    if current_folder_node == null:
        current_folder_node = get_folder_db().add_root_folder()

func get_comment_db() -> TodoNodeDB:
    return $DB/CommentDB

func get_folder_db() -> TodoNodeDB:
    return $DB/FolderDB

func get_connection_db() -> TodoNodeDB:
    return $DB/ConnectionDB

func get_db_manager():
    return $DB