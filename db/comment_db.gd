extends TodoNodeDB

func add(folder_id : String, data: Dictionary):
    var new_comment = CommentModel.new()
    new_comment.folder_uuid = folder_id
    var err = verify_data(data)
    if(err == OK):
        new_comment.position = data.position
    # else:
    #     push_warning("Position missing when adding "+new_comment.uuid)
    nodes.append(new_comment)
    return new_comment

# func verify_data(data : Dictionary) -> Error:
#     if data.has("comment"):
#         return OK
#     else:
#         return FAILED

func update(id, data) -> CommentModel:
    var comment_index = get_node_index(id)
    
    if comment_index == -1:
        return null
    
    if data.has("position"):
        nodes[comment_index].position = data.position
    
    if data.has("comment"):
        nodes[comment_index].comment = data.comment
    
    return nodes[comment_index]

func save():
    var data = ListResource.new()
    for node : CommentModel in nodes:
        var node_save_data = CommentSaveData.new()
        node_save_data.uuid = node.uuid
        node_save_data.comment = node.comment
        node_save_data.position = node.position
        node_save_data.folder_uuid = node.folder_uuid
        data.data.append(node_save_data)
    return data

func load(comments : ListResource):
    for value : CommentSaveData in comments.data:
        var new_comment = add(value.folder_uuid,{"position":value.position})
        replace_id(new_comment.uuid,value.uuid)
        update(value.uuid,{"position":value.position,"comment":value.comment})
