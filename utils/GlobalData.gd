extends Node

const PARENT_FOLDER_UUID : String = "0"
var current_folder_node : FolderModel


func _ready():
    if current_folder_node == null:
        current_folder_node = FolderModel.new()
        