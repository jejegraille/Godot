class_name DR_List

var length = 0;
var start : DR_ListElm = null;
var lastListAdded : DR_ListElm = null;

var last setget, _getLastElement 

func _init():
	pass;

func _getLastElement()->DR_ListElm:
	return lastListAdded;
	
func  _addElemToList(elem :DR_ListElm, atStart: bool):
	if atStart:
		elem.next = self.start;
		if self.start:
			self.start.prev = elem;
		else:
			self.lastListAdded = elem;
		self.start = elem;
		return;
	if elem != null:
		if self.start == null:
			self.start = elem;
		else:
			self.lastListAdded.next = elem;
		elem.prev = self.lastListAdded;
		self.lastListAdded = elem;
		self.length += 1;
	
func isLooped():
	if start && lastListAdded && start.prev == lastListAdded && lastListAdded.next == start:
		return true;
	else:
		return false;

func addToList(content, atStart : bool = false):
	var elem : DR_ListElm;
	if content is DR_ListElm:
		elem = content;
	else:
		elem = DR_ListElm.new(content);
	self._addElemToList(elem, atStart);
	return elem;

func getListElemAt(indx):
	var tmp = self.start;
	while tmp && indx:
		indx -= 1;
		tmp = tmp.next;
	return tmp;

func getContentAt(indx):
	var tmp = self.start;
	while tmp && indx:
		indx -= 1;
		tmp = tmp.next;
	return tmp.content;

func getElementFromContent(content):
	var tmp = self.start;
	while tmp:
		if tmp.content == content:
			return tmp;
		tmp = tmp.next;
	return null;

func invertElem(a:DR_ListElm, b:DR_ListElm):
	var an = a.next;
	var ap = a.prev;
	var bn = b.next;
	var bp = b.prev;
	var start = self.start;
	var last = self.lastListAdded;
	if an:
		an.prev = b;
	if ap:
		ap.next = b;
	if bn:
		bn.prev = a;
	if bp:
		bp.next = a;
	if last == b:
		self.lastListAdded = a;
	if last == a:
		self.lastListAdded = b;
	if start == b:
		self.start = a;
	if start == a:
		self.start = b;
	a.next = bn;
	a.prev = bp;
	b.next = an;
	b.prev = ap;

func removeFromList(content):
	var elem;
	if content is DR_ListElm:
		elem = content;
	else:
		elem = getElementFromContent(content);
	if elem == null:
		return;
	if elem == self.start:
		self.length -= 1;
		self.start = self.start.next;
		if self.start:
			self.start.prev = null;
		if self.lastListAdded == elem:
			self.lastListAdded = null;
	else:
		var prev = elem.prev;
		var next = elem.next;
		if prev:
			prev.next = next;
		if next:
			next.prev = prev;
		if self.lastListAdded == elem:
			self.lastListAdded = prev;
		if prev || next:
			self.length -= 1;
