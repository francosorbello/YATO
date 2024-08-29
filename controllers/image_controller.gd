extends Node
class_name ImageController

var image_db : ImageDB

func _ready() -> void:
    image_db = GlobalData.get_image_db()

func add_image(pos : Vector2, image : Image, new_id :String ="") -> ImageModel:
    var image_node = image_db.add(GlobalData.current_folder_node.uuid,{"position": pos, "image": image})
    if new_id != "":
        image_node = image_db.replace_id(image_node.uuid,new_id)
    return image_node

func update_image_position(id: String, pos: Vector2) -> ImageModel:
    return image_db.update(id,{"position":pos})

func delete_image(id) -> ImageModel:
    return image_db.delete(id)

func get_nodes_from_folder(folder_id : String) -> Array:
    return image_db.get_nodes_from_folder(folder_id)

func resize(id: String, size: Vector2) -> ImageModel:
    return image_db.update(id,{"size":size})