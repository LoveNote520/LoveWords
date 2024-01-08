import 'package:counter/algorithm_every_day/tree/tree_printer.dart';

import 'binary _tree.dart';

/// create by 星星 on 2024/1/1
/// contact me by email 1395723441@qq.com
/// 说明:

void main() {
  BinaryTree tree = BinaryTree<int>();
  tree.add(11);
  tree.add(4);
  tree.add(0);
  tree.add(3);
  tree.add(2);
  tree.add(81);
  tree.printTree();
  TreePrinter().printTreeNode(tree.root,0);
  print("${tree.findMax()}");
  print("${tree.findMin()}");
}
