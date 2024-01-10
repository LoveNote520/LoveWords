class LinkList<T> {
  LinkedNode<T>? _node;

  LinkList();

  factory LinkList.formArray(List<T> list) {
    LinkList<T> linkList = LinkList();
    for (var element in list) {
      linkList.add(element);
    }
    return linkList;
  }

  void add(T value) {
    var node = LinkedNode(value: value);
    if (_node != null) {
      _node?.next = node;
    } else {
      _node = node;
    }
  }
}

class LinkedNode<T> {
  LinkedNode<T>? next;
  T? value;

  LinkedNode({this.next, this.value});
}