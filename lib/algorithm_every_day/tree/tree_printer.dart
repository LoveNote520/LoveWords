
import 'binary _tree.dart';

class TreePrinter{

   TreePrinter();

  String pretty(TreeNode? node){
    List<String> res = [];
    prettyNode(node, res,0);
    return res.join('\n');
  }

  void prettyNode(TreeNode? node,List<String> res,int deep,){
    if (node == null) {
      return;
    }
    res.add('${"   "*deep} |_ ${node.val}');
    prettyNode(node.left, res,deep+1);
    prettyNode(node.right, res,deep+1);
  }


  List<int> nodesDepth = [];

  void printTreeNode(TreeNode? node, int depth) {
    if (node == null) {
      return;
    }
    String result = "";
    int i = 0;
    if (node.left != null && node.right != null) {
      nodesDepth.add(depth + 1);
    }
    while (i < depth) {
      if (i == 0 || (nodesDepth.contains(i) && node.right != null)) {
        result += "| ";
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