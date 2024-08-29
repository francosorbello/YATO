extends TodoNode

func set_image(image : Image) -> void:
    var imgTex = ImageTexture.create_from_image(image)
    $TextureRect.texture = imgTex