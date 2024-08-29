extends CommentController
class_name CodeController

func _ready() -> void:
    comment_db = GlobalData.get_code_db()