/// 定义单链表数据结构 SLinkedList<T>
/// 说明: 泛型类型 T 可为任意类型
/// 支持方法
/// [2023.12.02]
/// 添加 void addAt(int index, T value);
/// 删除 T? removeAt(int index);
/// 设置 void set(index,T value);
/// 删除 T? get(int index);
///
/// [2023.12.03]
/// 大小: int get size 维护链表节点的尺寸。 要求获取 size 时间复杂度 O(1)
/// 是否没有元素: bool get isEmpty
/// 是否有元素: bool get isNotEmpty
/// 清空: void clear()
///
/// [2023.12.04]
/// 尾结点添加元素: void addLast(T value)
/// 首结点添加元素: void addFirst(T value)
/// 移除尾结点: T? removeLast()
/// 移除首结点: T? removeFirst()
///
/// [2023.12.05]
/// 对应元素首索引 : int firstIndexOf(T value) 第一个出现的索引,不存在返回 -1
/// 对应元素尾索引 : int lastIndexOf(T value) 最后一个出现的索引,不存在返回 -1
/// 是否包含元素: bool contains(T value)
///
/// [2023.12.06]
/// 指定位置添加多个节点 : void addArrayAt(int index, List<T> values)
/// 移除范围内的节点: List<T> removeBetween(int start, int end)
///
/// [2023.12.07]
/// 通过列表构造
/// SLinkedList.array(List<T> values) 构造
///
/// 截取 [start,end) 范围内的元素，返回一个新的 SLinkedList 对象:
/// 注: 索引从 0 计数, 包含 start 不包含 end
///     截取不影响当前链表元素
/// SLinkedList<T> slice(int start, int end)
///
void main(){
  SLinkedList list =   SLinkedList.array([1,4,7,8,2,8,4,7]);
  print(list);
  list.slice(0, 3);
  print(list.slice(0, 3));
}

class SLinkedList<T> {
  final SListNode<T> _head = SListNode<T>(null);

  int _size = 0;

  factory SLinkedList.array(List<T> values) {
    SLinkedList<T> list = SLinkedList();
    list.addArrayAt(0, values);
    return list;
  }

  SLinkedList<T> slice(int start, int end) {
    SLinkedList<T> list ;
    SListNode<T>? cur = _head.next;
    for (int i = 0; i < start; i++) {
      cur = cur?.next;
    }
    List<T> sliceValue= [];
    for(int i = 0 ;i<end-start;i++){
      sliceValue.add(cur?.val as T);
      cur = cur?.next;
    }
    list = SLinkedList.array(sliceValue);
    return list;
  }

  /// region [2023.12.02]
  void addAt(int index, T value) {
    if (index > _size) {
      throw const OutIndexException();
    }
    SListNode<T>? cur = _head;
    for (int i = 0; i < index; i++) {
      cur = cur?.next;
    }
    SListNode<T> newNode = SListNode(value);
    newNode.next = cur?.next;
    cur?.next = newNode;
    _size++;
  }

  T? removeAt(int index) {
    if (index >= _size) {
      throw const OutIndexException();
    }
    SListNode<T>? cur = _head;
    for (int i = 0; i < index; i++) {
      cur = cur?.next;
    }
    SListNode<T>? target = cur?.next;
    cur?.next = target?.next;
    target?.next = null;
    _size--;
    return target?.val;
  }

  void set(int index, T value) {
    if (index >= _size) {
      throw const OutIndexException();
    }
    SListNode<T>? cur = _head.next;
    for (int i = 0; i < index; i++) {
      cur = cur?.next;
    }
    cur?.val = value;
  }

  T? get(int index) {
    if (index >= _size) {
      throw const OutIndexException();
    }
    SListNode<T>? cur = _head.next;
    for (int i = 0; i < index; i++) {
      cur = cur?.next;
    }
    return cur?.val;
  }

  //// endregion

  /// region [2023.12.03]
  int get size => _size;

  bool get isEmpty => !isNotEmpty;

  bool get isNotEmpty => _size > 0;

  void clear() {
    _head.next = null;
    _size = 0;
  }

  //// endregion

  /// region [2023.12.04]
  void addFirst(T value) {
    addAt(0, value);
  }

  void addLast(T value) {
    addAt(_size, value);
  }

  T? removeFirst() {
    return removeAt(0);
  }

  T? removeLast() {
    return removeAt(_size - 1);
  }

  //// endregion

  /// region [2023.12.05]
  int firstIndexOf(T value) {
    return _findIndex(value);
  }

  int lastIndexOf(T value) {
    return _findIndex(value, first: false);
  }

  int _findIndex(T value, {bool first = true}) {
    int result = -1;
    int counter = 0;
    SListNode<T>? cur = _head.next;
    while (cur != null) {
      if (cur.val == value) {
        result = counter;
        if (first) break;
      }
      counter++;
      cur = cur.next;
    }
    return result;
  }

  bool contains(T value) {
    return firstIndexOf(value) != -1;
  }

  //// endregion
  void addArrayAt(int index, List<T> values) {
    if (index > _size) {
      throw const OutIndexException();
    }
    SListNode<T>? cur = _head;
    for (int i = 0; i < index; i++) {
      cur = cur?.next;
    }
    SListNode<T>? next = cur?.next;
    SListNode<T>? newNode = cur;
    for (int i = 0; i < values.length; i++) {
      newNode = SListNode(values[i]);
      cur?.next = newNode;
      cur = newNode;
    }
    newNode?.next = next;
    _size += values.length;
  }

  List<T> removeBetween(int start, int end) {
    List<T> ret = [];
    SListNode<T>? cur = _head.next;
    SListNode<T>? startPre;
    SListNode<T>? endNode;
    int step = end - start;
    for (int i = 0; i < start - 1; i++) {
      cur = cur?.next;
    }
    startPre = cur;
    for (int i = 0; i <= step; i++) {
      cur = cur?.next;
      T? val = cur?.val;
      if (val != null) {
        ret.add(val);
      }
    }
    endNode = cur;
    startPre?.next = endNode?.next;
    endNode?.next = null;
    _size -= step + 1;
    return ret;
  }

  SLinkedList();

  @override
  String toString() {
    return _head.next.toString();
  }
}

class SListNode<T> {
  T? val;
  SListNode<T>? next;

  SListNode(this.val, [this.next]);

  @override
  String toString() {
    SListNode<T>? cur = this;
    String result = "";
    while (cur != null) {
      result = result + cur.val.toString();
      cur = cur.next;
      if (cur != null) {
        result += '->';
      }
    }
    return result;
  }
}

class OutIndexException implements Exception {
  String? get message => "index out size";

  StackTrace? get stackTrace => null;

  const OutIndexException();

  @override
  String toString() => "OutIndexException";
}
