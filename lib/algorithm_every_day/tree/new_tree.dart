import 'package:counter/algorithm_every_day/tree/tree_node.dart';

void main() {
  TreeNode rightLLLL = TreeNode(val: "permissionHandler");
  TreeNode leftLLLL = TreeNode(val: "permissionHandler");
  TreeNode rightLLL = TreeNode(val: "baseFlow", left: rightLLLL);
  TreeNode leftLLL = TreeNode(val: "baseFlow", left: leftLLLL);
  TreeNode rightLL = TreeNode(val: "com", left: rightLLL);
  TreeNode leftLL = TreeNode(val: "com", left: leftLLL);
  TreeNode rightL = TreeNode(val: "classes", left: rightLL);
  TreeNode leftL = TreeNode(val: "classes", left: leftLL);
  TreeNode right = TreeNode(val: "release", left: rightL);
  TreeNode left = TreeNode(val: "debug", left: leftL);
  TreeNode node = TreeNode(val: "javac", left: left, right: right);
  NewTree tree = NewTree(node);
  tree.printTree();
}

class NewTree {
  final TreeNode _newNode;

  NewTree(this._newNode);

  TreeNode get node => _newNode;

  void printTree() {
    printTreeNode(_newNode, 0);
  }

  void printTreeNode(TreeNode? node, int depth) {
    if (node == null) {
      return;
    }
    String result = "";
    int i = 0;
    int depth0 = -1;
    while (i < depth) {
      if (node.left != null && node.right != null) {
        depth0 = depth;
        result += "|  ";
      } else if (depth0 == depth) {
        result += "|";
      } else {
        result += "  ";
      }
      i++;
    }
    result += "|_";

    result += node.val.toString();
    print("$result");

    printTreeNode(node.left, depth + 1);
    printTreeNode(node.right, depth + 1);
  }
}
