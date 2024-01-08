/// create by 星星 on 2024/1/1
/// contact me by email 1395723441@qq.com
/// 说明:

/// [2024-01-01]
/// 1.设计 BinaryTree 类型完成 add 方法: void add(T t)
/// 添加时二叉树需要满足:
///    节点值 >= 左子值。
///    节点值 < 右子值。
///
/// 测试案例:
/// ```
/// BinaryTree tree = BinaryTree<int>();
///  tree.add(9);
///  tree.add(4);
///  tree.add(0);
///  tree.add(3);
///  tree.add(2);
///  tree.add(8);
///  print(json.encode(tree.toJson()));
/// ```
/// 输出:
/// {"val":9,"right":{"val":4,"left":{"val":8},"right":{"val":0,"left":{"val":3,"right":{"val":2}}}}}
///
///
///
///
/// 快速构建一颗树
class BinaryTree<T extends Comparable> {
  TreeNode<T>? root;

  BinaryTree();

  factory BinaryTree.fromArray(List<T> array) {
    BinaryTree<T> tree = BinaryTree<T>();
    for (var element in array) {
      tree.add(element);
    }
    return tree;
  }

  T findMax() {
    return _findValue(root, type: "max")!;
  }

  T findMin() {
    return _findValuePro(root, type: "min")!;
  }


  T? _findValue(TreeNode<T>? node, {String? type = "max"}) {
    if (node == null) return null;
    if (type == "max") {
      T? maxValue = node.val;
      T? leftMax = _findValue(node.left, type: "max");
      if (leftMax != null && leftMax.compareTo(maxValue) > 0) {
        maxValue = leftMax;
      }
      T? rightMax = _findValue(node.right, type: "max");
      if (rightMax != null && rightMax.compareTo(maxValue) > 0) {
        maxValue = rightMax;
      }
      return maxValue;
    }
    else {
      T? minValue = node.val;
      T? leftMin = _findValue(node.left, type: "min");
      if (leftMin != null && leftMin.compareTo(minValue) < 0) {
        minValue = leftMin;
      }
      T? rightMin = _findValue(node.right, type: "min");
      if (rightMin != null && rightMin.compareTo(minValue) < 0) {
        minValue = rightMin;
      }
      return minValue;
    }
  }

  T? _findValuePro(TreeNode<T>? node, {String? type = "max"}) {
    if (node == null) return null;
    if (type == "max") {
      T? maxValue = node.val;
      T? rightMax = _findValuePro(node.right, type: "max");
      if (rightMax != null && rightMax.compareTo(maxValue) > 0) {
        maxValue = rightMax;
      }
      return maxValue;
    }
    else {
      T? minValue = node.val;
      T? leftMin = _findValuePro(node.left, type: "min");
      if (leftMin != null && leftMin.compareTo(minValue) < 0) {
        minValue = leftMin;
      }
      return minValue;
    }
  }


  void add(T val) {
    if (root == null) {
      root = TreeNode(val: val);
    } else {
      _addNode(root!, val);
    }
  }

  void _addNode(TreeNode<T>? node, T val) {
    if (val.compareTo(node?.val) > 0) {
      if (node?.right == null) {
        node?.right = TreeNode(val: val);
      } else {
        _addNode(node?.right, val);
      }
    } else {
      if (node?.left == null) {
        node?.left = TreeNode(val: val);
      } else {
        _addNode(node?.left, val);
      }
    }
  }

  void printTree() {
    traversal(root);
  }

  void traversal(TreeNode<T>? node) {
    if (node == null) {
      return;
    }
    traversal(node.left);
    traversal(node.right);
    print(node.val);
  }
}

class TreeNode<T extends Comparable> {
  TreeNode<T>? left;
  TreeNode<T>? right;
  T? val;

  TreeNode({
    this.left,
    this.right,
    this.val,
  });
}
