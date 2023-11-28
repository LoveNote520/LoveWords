void main() {
  ListNode listNode = ListNode(0, ListNode(3, ListNode(2, ListNode(8))));
  print(listNode);
  ListNode? findNode = listNode.find(8);
  print(findNode);
}

class ListNode {
  int val;
  ListNode? next;

  ListNode([this.val = 0, this.next]);

  @override
  String toString() {
    ListNode? cur = this;
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

  /// TODO: 完成 find 函数，在链表中查找指定值的首位节点
  ListNode? find(int target) {
    ListNode? cur = this;
    while (cur?.val != target) {
      if (cur?.next != null) {
        cur = cur?.next;
      } else {
        return null;
      }
    }
    return cur;
  }
}
