extends TodoNodeDB
class_name ImageDB

func add(folder_id : String, data: Dictionary):
    var new_image_node = ImageModel.new()
    new_image_node.folder_uuid = folder_id
    var err = verify_data(data)
    if(err == OK):
        new_image_node.position = data.position
    if data.has("image"):
        new_image_node.image = data.image
    nodes.append(new_image_node)
    return new_image_node

func update(id, data) -> ImageModel:
    var image_index = get_node_index(id)
    
    if image_index == -1:
        return null
    
    if data.has("position"):
        nodes[image_index].position = data.position
    
    super.update(id,data)
    
    return nodes[image_index]

func save():
    var data = ListResource.new()
    for node : ImageModel in nodes:
        var node_save_data = ImageSaveData.new()
        node_save_data.uuid = node.uuid
        node_save_data.image = node.image
        node_save_data.position = node.position
        node_save_data.folder_uuid = node.folder_uuid
        node_save_data.size = node.size
        data.data.append(node_save_data)
    return data

func load(images : ListResource):
    for value : ImageSaveData in images.data:
        var new_image = add(value.folder_uuid,{"position":value.position,"image":value.image})
        replace_id(new_image.uuid,value.uuid)
        update(value.uuid,{"position":value.position,"image":value.image, "size":value.size})
