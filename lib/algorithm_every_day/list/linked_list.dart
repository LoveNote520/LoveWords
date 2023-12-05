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
library;

void main() {
  SLinkedList<int> sList = SLinkedList();
  sList.addAt(0, 1);
  sList.addAt(1, 2);
  sList.addAt(0, 3);
  sList.addAt(1, 4);
  print(sList); // 3->4->1->2
  print(sList.size); // 4

  // sList.removeAt(2);
  // print(sList); // 3->4->2
  //
  // sList.set(2, 1);
  // print(sList); // 3->4->1
  // print(sList.get(2)); //

  sList.addFirst(5);
  print(sList); // 5->3->4->1

  sList.addLast(6);
  print(sList); // 5->3->4->1->6

  sList.removeFirst();
  print(sList); // 3->4->1->6

  sList.removeLast();
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
    removeAt(_size);
  }

  void removeFirst() {
    removeAt(0);
  }

  /// [2023.12.05]
  /// 对应元素首索引 : int firstIndexOf(T value) 第一个出现的索引,不存在返回 -1
  /// 对应元素尾索引 : int lastIndexOf(T value) 最后一个出现的索引,不存在返回 -1
  /// 是否包含元素: bool contains(T value)

  int _indexOf(T value, {int start = 0}) {
    SListNode? cur = _head.next;
    int index = start;

    while (cur != null) {
      if (cur.val == value) return index;
      cur = cur.next;
      index++;
    }

    return -1;
  }

  int firstIndexOf(T value) {
    return _indexOf(value);
  }

  int lastIndexOf(T value) {
    int last = -1;
    int index = _indexOf(value);

    while (index != -1) {
      last = index;
      index = _indexOf(value, start: last + 1);
    }

    return last;
  }

  bool contains(T value) {
    return firstIndexOf(value) != -1;
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
