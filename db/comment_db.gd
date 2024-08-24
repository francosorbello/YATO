extends TodoNodeDB

func add(folder_id : String, data: Dictionary):
    var new_comment = CommentModel.new()
    new_comment.folder_uuid = folder_id
    var err = verify_data(data)
    if(err == OK):
        new_comment.position = data.position
    else:
        push_warning("Position missing when adding "+new_comment.uuid)

    return new_comment

# func verify_data(data : Dictionary) -> Error:
#     if data.has("comment"):
#         return OK
#     else:
#         return FAILED
