extends TodoNodeDB

func add(folder_id : String, data : Dictionary) -> TaskModel:
    var new_task = TaskModel.new()
    new_task.folder_uuid = folder_id
    if data.has("position"):
        new_task.position = data.position
    nodes.append(new_task)
    return new_task

func update(id : String, data : Dictionary) -> TaskModel:
    var i = get_node_index(id)

    if i == -1:
        return null
    
    if data.has("position"):
        nodes[i].position = data.position

    if data.has("title"):
        nodes[i].title = data.title
    
    return nodes[i]
