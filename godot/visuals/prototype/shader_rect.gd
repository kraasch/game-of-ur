extends ColorRect
class_name  MyShaderRect

const POST_PROCESSING_BLUR : Resource = preload("res://shaders/post-processing_blur.gdshader")
const POST_PROCESSING_CHROMATIC : Resource = preload("res://shaders/post-processing_chromatic.gdshader")
const POST_PROCESSING_WOBBLE : Resource = preload("res://shaders/post-processing_wobble.gdshader")

@onready var SHADERS : Array[Resource] = [
	POST_PROCESSING_BLUR, 
	POST_PROCESSING_CHROMATIC,
	POST_PROCESSING_WOBBLE,
	Shader.new(),
]
@onready var shader_rect : MyShaderRect = %shader_rect

var index: int = -1

func _ready() -> void:
	shader_rect.material.shader = POST_PROCESSING_CHROMATIC

func next_item():
	index = (index + 1) % SHADERS.size()
	return SHADERS[index]

func _on_shader_button_pressed() -> void:
	if not shader_rect:
		return
	if not shader_rect.material:
		return
	shader_rect.material.shader = next_item()
