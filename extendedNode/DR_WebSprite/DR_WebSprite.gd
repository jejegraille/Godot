extends Sprite

class_name DR_WebSprite

export var url : String;
export var maxSizeEnable : bool;
export var maxWidth : float;
export var maxHeight : float;

const _urlArchived = {};
var _texture : ImageTexture = null;

signal onLoaded

func _ready():
	loadImg();

func loadImg():
	if _urlArchived.has(url):
		_texture = _urlArchived[url];
		setImage();
		return;
	
	var http_request = HTTPRequest.new();
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	
	var http_error = http_request.request(url);
	if http_error != OK:
		print("An error occurred in the HTTP request.")

func _http_request_completed(result, response_code, headers, body):
	var tab = ["load_jpg_from_buffer", "load_webp_from_buffer", "load_png_from_buffer"];
	var res = null;
	var image;
	var i = 0;
	while i < 3 && res != OK:
		image = Image.new();
		res = funcref(image, tab[i]).call_func(body);
		i += 1;
	if res != OK:
		print("webSprite error: image format unknow");
		return;
	_texture = ImageTexture.new()
	_texture.create_from_image(image);
	_urlArchived[url] = _texture;
	setImage();
	
func setImage():
	texture = _texture;
	if maxSizeEnable:
		var scale = min(maxWidth / float(_texture.get_width()), maxHeight / float(_texture.get_height()));
		self.scale.x = scale;
		self.scale.y = scale;
	emit_signal("onLoaded");
