import 'package:counter/algorithm_every_day/tree/tree_printer.dart';

import 'binary _tree.dart';

/// create by 星星 on 2024/1/1
/// contact me by email 1395723441@qq.com
/// 说明:

void main() {
  BinaryTree tree1 = BinaryTree<int>.fromArray([11,6,8,9,3,12,16,2,]);
  BinaryTree tree2 = BinaryTree<int>.fromArray([4,8,2,9,7,14,18,5,]);

BinaryTree tree = BinaryTree<int>();
  // tree.printTree();
  // TreePrinter().printTreeNode(tree.root,0);
  // print("${tree.findMax()}");
  // print("${tree.findMin()}");

   TreePrinter().printTreeNode(tree.mergeTrees(tree1.root, tree2.root),0);
  // print("${tree2.toList()}");
}
