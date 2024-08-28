extends TodoNodeDB

func add(task_id : String, data: Dictionary):
    var new_task_item = TaskItemModel.new()
    new_task_item.folder_uuid = task_id

    if(data.has("finished")):
        new_task_item.finished = data.finished
    if(data.has("title")):
        new_task_item.title = data.title

    nodes.append(new_task_item)
    return new_task_item

func update(id, data) -> TaskItemModel:
    var task_item_index = get_node_index(id)
    
    if task_item_index == -1:
        return null
    
    if data.has("finished"):
        nodes[task_item_index].finished = data.finished
    
    if data.has("title"):
        nodes[task_item_index].title = data.title

    if data.has("slot"):
        nodes[task_item_index].slot = data.slot
    
    return nodes[task_item_index]

func save():
    var data = ListResource.new()
    for node : TaskItemModel in nodes:
        var node_save_data = TaskItemSaveData.new()
        node_save_data.uuid = node.uuid
        node_save_data.finished = node.finished
        node_save_data.title = node.title
        node_save_data.folder_uuid = node.folder_uuid
        data.data.append(node_save_data)
    return data

func load(items : ListResource):
    for value : TaskItemSaveData in items.data:
        var new_task_item = add(value.folder_uuid,{"finished":value.finished,"title":value.title})
        replace_id(new_task_item.uuid,value.uuid)
        update(value.uuid,{"finished":value.finished,"title":value.title})

func get_items_for_task(task_id : String) -> Array:
    var items = []
    for node in nodes:
        if node.folder_uuid == task_id:
            items.append(node)
    return items