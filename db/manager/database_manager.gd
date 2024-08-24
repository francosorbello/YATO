extends Node

func get_comment_db() -> TodoNodeDB:
    return $CommentDB

func get_folder_db() -> TodoNodeDB:
    return $FolderDB