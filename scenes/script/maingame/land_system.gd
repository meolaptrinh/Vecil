extends Node
@onready var map = $"../map";
@onready var maingame_data = $"../maingame_data";
@onready var mapRoad = [];
const DIR8 = [
	Vector2i(-1, -1),
	Vector2i( 0, -1),
	Vector2i( 1, -1),
	Vector2i(-1,  0),
	Vector2i( 1,  0),
	Vector2i(-1,  1),
	Vector2i( 0,  1),
	Vector2i( 1,  1)
]
func _ready() -> void:
	pass;
#func _process(delta: float) -> void:
	#pass
func land_scan():
	mapRoad = [];
	var w = map.texture.get_width();
	var h = map.texture.get_height();
	var imgtex = map.texture.get_image();
	for x in range(w):
		var k = [];
		for y in range(h):
			var map_color = imgtex.get_pixel(x,y);
			if abs(map_color.r * 255 - map_data.maps[maingame_data.level_id]["vn"]["r"]) < 0.5 and abs(map_color.g * 255 - map_data.maps[maingame_data.level_id]["vn"]["g"]) < 0.5 and abs(map_color.b * 255 - map_data.maps[maingame_data.level_id]["vn"]["b"]) < 0.5:
				k.append(1);
			else:
				k.append(0);
		mapRoad.append(k);
func find_path(start: Vector2i, target: Vector2i) -> Array:
	var road = mapRoad

	if road.is_empty():
		return []

	var w = road.size()
	var h = road[0].size()

	# Kiểm tra tọa độ hợp lệ
	if start.x < 0 or start.y < 0 or start.x >= w or start.y >= h:
		return []

	if target.x < 0 or target.y < 0 or target.x >= w or target.y >= h:
		return []

	# Điểm đầu hoặc cuối không đi được
	if road[start.x][start.y] == 0:
		return []

	if road[target.x][target.y] == 0:
		return []

	var visited = []
	var parent = []

	for x in range(w):
		visited.append([])
		parent.append([])
		for y in range(h):
			visited[x].append(false)
			parent[x].append(Vector2i(-1, -1))

	var queue: Array[Vector2i] = []
	var head = 0

	queue.append(start)
	visited[start.x][start.y] = true

	while head < queue.size():
		var cur = queue[head]
		head += 1

		if cur == target:
			break

		for d in DIR8:
			var nxt = cur + d

			if nxt.x < 0 or nxt.y < 0:
				continue
			if nxt.x >= w or nxt.y >= h:
				continue
			if visited[nxt.x][nxt.y]:
				continue
			if road[nxt.x][nxt.y] == 0:
				continue

			visited[nxt.x][nxt.y] = true
			parent[nxt.x][nxt.y] = cur
			queue.append(nxt)

	if !visited[target.x][target.y]:
		return []

	var path: Array[Vector2i] = []
	var cur = target

	while cur != start:
		path.push_front(cur)
		cur = parent[cur.x][cur.y]

	path.push_front(start)

	return path
func nearest_land(pos: Vector2i) -> Vector2i:
	if mapRoad.is_empty():
		return pos

	var w = mapRoad.size()
	var h = mapRoad[0].size()

	# Nếu đang đứng trên đất thì giữ nguyên
	if pos.x >= 0 and pos.y >= 0 and pos.x < w and pos.y < h:
		if mapRoad[pos.x][pos.y] == 1:
			return pos

	# Tìm ô đất gần nhất
	for r in range(1, 50):
		for d in DIR8:
			var p = pos + d * r

			if p.x < 0 or p.y < 0:
				continue
			if p.x >= w or p.y >= h:
				continue

			if mapRoad[p.x][p.y] == 1:
				return p

	return pos
