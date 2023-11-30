void main() {
  // ListNode listNode = ListNode(1, ListNode(2, ListNode(3, ListNode(4))));
  // print(listNode);
  // ListNode? findNode = listNode.find(0);
  // if (findNode != null) {
  //   // 0->2->8
  // }
  // listNode.getEvenValue();
  // print(listNode.getEvenValue());
  // print(listNode.swapFrontTwo().toString());

  // print(listNode.swapNextProMax(1).toString());

  // ListNode listNode = ListNode.array([1, 9, 9, 4, 0, 3, 2, 8]);
  ListNode listNode = ListNode.array([1, 1, 2, 2, 3, 3, ]);
  // ListNode? result = listNode.removeBetween(listNode,  3, 5);
  // print(addNodeAfter(listNode,7,5));
  // print(addNodeAfterPro(node:listNode,7,5));
  print(deleteDuplicates(listNode));
}

/// TODO: LeetCode 83. 删除有序链表中的重复元素
/// 说明 : 链表节点已从小到大排序
/// 输入：链表 a = [1,1,2,3,3]
/// 输出：链表  [1,2,3]
ListNode? deleteDuplicates(ListNode? node) {
  ListNode? cur = node;
  while (cur != null) {
    if (cur.val == cur.next?.val) {
      cur.next = cur.next?.next;
    }
    cur = cur.next;
  }
  return node;
}

/// TODO: 在链表 node 第一个值为 target的节点后，插入一个 value 的新节点。
/// 说明: 如果链表中没有 target 节点，将 value 节点加到链表最后。
/// 输入：链表 a = [0->3->2->8], target = 3; value=5
/// 输出：链表 a = [0->3->5->2->8]
///

ListNode? addNodeAfter(ListNode node, int target, int value) {
  ListNode? cur = node;
  ListNode d = ListNode(value);
  while (cur != null) {
    if (cur.val == target) {
      d.next = cur.next;
      cur.next = d;
      return node;
    }
    if (cur.next == null) {
      cur.next = d;
      return node;
    }
    cur = cur.next;
  }

  return node;
}

ListNode? addNodeAfterPro(
  int target,
  int value, {
  ListNode? node,
}) {
  if (node == null) return ListNode(value);
  if (node.val == target) {
    ListNode newNode = ListNode(value);
    newNode.next = node.next;
    node.next = newNode;
    return node;
  }
  node.next = addNodeAfterPro(
    target,
    value,
    node: node.next,
  );
  return node;
}

/// [2023.11.27]
/// TODO: 完成  getEvenNodes 方法, 返回所有偶数节点依次形成的链表
/// 输入：链表 a = [1->9->9->4->0->3->2->8]
/// 输出：链表 a = [1->9->0->2]
/// 说明 : 计数从 0 开始，第一个节点为偶数
ListNode? getEvenNodes(ListNode node) {
  ListNode? f = node;
  ListNode? s = node.next;
  while (f != null || s != null) {
    f?.next = s?.next;
    f = f?.next;
    s = s?.next?.next;
  }

  return node;
}

class ListNode {
  int val;
  ListNode? next;

  ListNode([this.val = 0, this.next]);

  /// [2023.11.26]
  /// TODO: 完成  removeBetween 方法，删除 [start~end] 间的节点
  /// 输入：链表 a = [1->9->9->4->0->3->2->8] ; start = 3 end = 5 (从 0 开始计数)
  /// 输出：链表 a = [1->9->9->2->8] ; start = 3 end = 5
  /// 条件(无需校验) : start < end ; end < 列表长度;
  ListNode? removeBetween(ListNode node, int start, int end) {
    ListNode d = ListNode(0, node);
    ListNode? f = d;
    ListNode? s = d;

    for (int i = 0; i < start; i++) {
      f = f?.next;
      s = s?.next;
    }
    for (int j = 0; j < (end - start) + 1; j++) {
      s = s?.next;
    }
    f?.next = s?.next;
    s?.next = null;

    return d.next;
  }

  /// TODO: 完成  swapNext 方法，交换链第 i 个节点和后一节点的位置
  /// 备注: i 从 0 开始计数，i < 链表长度-1
  ///输入：链表 = [1,2,3,4] , i = 2
// 输出：[1,2,4,3]
  ListNode? swapNext(int i) {
    if (i > size() - 1) {
      return null;
    }
    ListNode? d = ListNode(0, this);
    ListNode? cur = this;
    for (int j = 0; j < i; j++) {
      d = d?.next;
      cur = cur?.next;
    }
    ListNode? pre = cur?.next;
    cur?.next = pre?.next;
    pre?.next = cur;
    if (i == 0) {
      return pre;
    } else {
      d?.next = pre;
      return this;
    }
  }

  ListNode? swapNextProMax(int i) {
    if (i > size() - 1) {
      return null;
    }
    ListNode? d = ListNode(0, this);
    ListNode? cur = d;
    for (int j = 0; j < i; j++) {
      cur = cur?.next;
    }
    ListNode? t = cur?.next;
    ListNode? r = t?.next;
    cur?.next = r;
    t?.next = r?.next;
    r?.next = t;
    return d.next;
  }

  /// [2023.11.25]
  /// TODO: 完成 swapFrontTwo 方法，交换链表前两个节点的位置
  ///输入：链表 = [1,2,3,4]
// 输出：[2,1,3,4]
  ListNode? swapFrontTwo() {
    ListNode cur = this;
    ListNode? pre = next;
    cur.next = pre?.next;
    pre?.next = cur;
    return pre;
  }

  /// TODO: 完成 ListNode.array 构造方法，
  /// 通过入参列表创建链表
  /// 例如: 入参是 [1,4,3,2,5,2]
  /// 返回链表: 1->4->3->2->5->2
  factory ListNode.array(List<int> array) {
    if (array.isNotEmpty) {
      ListNode d = ListNode(0);
      ListNode? cur = d;
      for (var element in array) {
        cur?.next = ListNode(element);
        cur = cur?.next;
      }
      return d.next!;
    }
    return ListNode();
  }

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

  /// [2023.11.21] TODO: 完成 find 函数，在链表中查找指定值的首位节点
  ListNode? find(int target) {
    ListNode? cur = this;
    while (cur != null) {
      if (cur.val == target) {
        return cur;
      }
      cur = cur.next;
    }
    return null;
  }

  int size() {
    ListNode? cur = this;
    int size = 0;
    while (cur != null) {
      size += 1;
      cur = cur.next;
    }
    return size;
  }

  /// [2023.11.23]
  /// TODO: 完成 getEvenValue 方法，
  /// 返回链表中偶数节点的值列表
  List<int> getEvenValue() {
    List<int> result = [];
    ListNode? cur = this;
    int i = 0;
    while (cur != null) {
      if (i % 2 == 0) {
        result.add(cur.val);
      }
      cur = cur.next;
      i++;
    }
    return result;
  }

  /// TODO: 完成 getValueByStep 方法，
  /// 返回链表中每隔 step 个节点的值列表
  /// 例:
  /// 链表: 0->3->2->8->9
  /// step=3 : 输出 [0, 8]
  /// step=2 : 输出 [0, 2, 9]
  List<int> getValueByStep(int step) {
    List<int> result = [];

    return result;
  }
}

/// TODO: LeetCode 1669 合并两个链表
/// 给你两个链表 a 和 b ，它们包含的元素分别为 n 个和 m 个。
// 请你将 a 中下标从 start 到 end 的全部节点都删除，并将 b 接在被删除节点的位置。
/// 输入：链表 a = [0, 1, 2, 3, 4, 5, 6] ; 链表 b = [1000000, 1000001, 1000002, 1000003, 1000004] ; start=2;end = 4
//  输出：[0->1->1000000->1000001->1000002->1000003->1000004->5->6]
ListNode? mergeListNode(ListNode a, int start, int end, ListNode b) {
  ListNode? dummy = ListNode(0, a);
  ListNode? cur = dummy;
  ListNode? startPre;
  ListNode? endNode;
  ListNode? bEnd;

  for (int i = 0; i <= end + 1; i++) {
    if (i == start) {
      startPre = cur;
    }
    if (i == end + 1) {
      endNode = cur;
    }
    cur = cur?.next;
  }

  bEnd = b;
  while (bEnd?.next != null) {
    bEnd = bEnd?.next;
  }

  startPre?.next = b;
  bEnd?.next = endNode?.next;
  endNode?.next = null;
  return dummy.next;
}
