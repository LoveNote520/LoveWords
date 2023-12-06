/// 定义单链表数据结构 SLinkedList<T>
/// 说明: 泛型类型 T 可为任意类型
/// 支持方法
/// [2023.12.02]
/// 添加 void addAt(int index, T value);
/// 删除 void removeAt(int index);
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
/// 移除尾结点: void removeLast()
/// 移除首结点: void removeFirst()
///


void main(){
  SLinkedList<int> sList = SLinkedList();
  sList.addAt(0, 1);
  sList.addAt(1, 2);
  sList.addAt(0, 3);
  sList.addAt(1, 4);
  print(sList); // 3->4->1->2
  print(sList.size); // 4

  sList.removeAt(2);
  print(sList); // 3->4->2

  sList.set(2,1);
  print(sList); // 3->4->1
  print(sList.get(2)); //1

  sList.addFirst(5);
  print(sList); // 5->3->4->1

  sList.addLast(6);
  print(sList); // 5->3->4->1->6

  sList.removeFirst();
  print(sList); // 3->4->1->6
  print(sList.size);//4
  sList.removeLast();
  print(sList); // 3->4->1

   sList.addAt(2,4);
   print(sList); // 3->4->4->1

   int firstIndex = sList.firstIndexOf(4);
   print(firstIndex); // 1

  int lastIndex = sList.lastIndexOf(4);
  print(lastIndex); // 2

   bool contains = sList.contains(3);
   print(contains); // 1

   sList.addArrayAt(3, [999,998]);
   print(sList); // 3->4->4->999->998->1
  //
  List<int> ret = sList.removeBetween(2, 4);
  print(ret); // [4, 999, 998]
  print(sList); // 3->4->1
}
class SLinkedList<T> {
  final SListNode<T> _head = SListNode<T>(null);

  int _size = 0;

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

  void removeAt(int index) {
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

  int get size => _size;

  bool get isEmpty => !isNotEmpty;

  bool get isNotEmpty => _size > 0;

  void clear() {
    _head.next = null;
    _size = 0;
  }

  void addLast(T value) {
    addAt(_size, value);
  }

  void addFirst(T value) {
    addAt(0, value);
  }

  void removeLast() {
    removeAt(_size-1);
  }

  void removeFirst() {
    removeAt(0);
  }

  /// [2023.12.05]
  /// 对应元素首索引 : int firstIndexOf(T value) 第一个出现的索引,不存在返回 -1
  /// 对应元素尾索引 : int lastIndexOf(T value) 最后一个出现的索引,不存在返回 -1
  /// 是否包含元素: bool contains(T value)

  int _indexOf(T value, {bool start = true}) {
    int result = -1;
    int counter = 0;
    SListNode<T>? cur = _head.next;
    while (cur != null) {
      if (cur.val == value) {
        result = counter;
        if (start) break;
      }
      cur = cur.next;
    }
    return result;
  }

  int firstIndexOf(T value) {
    return _indexOf(value);
  }

  int lastIndexOf(T value) {

    return _indexOf(value,start:false);
  }

  bool contains(T value) {
    return firstIndexOf(value) != -1;
  }

  /// [2023.12.06]
  /// 指定位置添加多个节点 : void addArrayAt(int index, List<T> values)
  /// 移除范围内的节点: List<T> removeBetween(int start, int end)
  ///
  ///
  void addArrayAt(int index, List<T> values) {
    for (int i = 0; i < values.length; i++) {
      addAt(index + i, values[i]);
    }
    _size = _size + values.length;
  }

  List<T> removeBetween(int start, int end) {
    List<T> removeValue = [];
    for (int i = end - start; i >= 0; i--) {
      removeValue.add(get(start) as T);
      removeAt(start);
    }
    _size = _size - (end - start);
    return removeValue;
  }

  @override
  String toString() {
    SListNode<T>? cur = _head.next;
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

class SListNode<T> {
  T? val;
  SListNode<T>? next;

  SListNode(this.val, [this.next]);
}

class OutIndexException implements Exception {
  String? get message => "index out size";

  StackTrace? get stackTrace => null;

  const OutIndexException();

  @override
  String toString() => "OutIndexException";
}
