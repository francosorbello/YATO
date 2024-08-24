extends TodoNodeDB

func add(folder_id : String, data: Dictionary):
    var new_comment = CommentModel.new()
    new_comment.folder_uuid = folder_id
    var err = verify_data(data)
    if(err == OK):
        new_comment.position = data.position
    else:
        push_warning("Position missing when adding "+new_comment.uuid)
    nodes.append(new_comment)
    return new_comment

# func verify_data(data : Dictionary) -> Error:
#     if data.has("comment"):
#         return OK
#     else:
#         return FAILED

func update(id, data):
    var comment_index = get_node_index(id)
    
    if comment_index == -1:
        return null
    
    if data.has("position"):
        nodes[comment_index].position = data.position
    
    if data.has("comment"):
        nodes[comment_index].comment = data.comment
    
    return nodes[comment_index]