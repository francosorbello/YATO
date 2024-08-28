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

    super.update(id,data)
    
    return nodes[i]

func save():
    var data = ListResource.new()
    for node : TaskModel in nodes:
        var node_save_data = TaskSaveData.new()
        node_save_data.uuid = node.uuid
        node_save_data.title = node.title
        node_save_data.position = node.position
        node_save_data.folder_uuid = node.folder_uuid
        node_save_data.size = node.size
        data.data.append(node_save_data)
    return data

func load(tasks : ListResource):
    for value : TaskSaveData in tasks.data:
        var new_task = add(value.folder_uuid,{"position":value.position})
        replace_id(new_task.uuid,value.uuid)
        update(value.uuid,{"position":value.position,"title":value.title, "size":value.size})