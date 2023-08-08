//完整版
class CompleteLoveStory {
  final int id;
  final String content;

  const CompleteLoveStory({
    required this.id,
    required this.content,
  });
  Map<String, dynamic> toDbJson() => {
    "id": id,
    "content": content,
  };
}

//隐藏版
class CutoffLoveStory {
  final int id;

  final String startContent;
  final String endContent;

  const CutoffLoveStory({
    required this.id,
    required this.endContent,
    required this.startContent,
  });

  Map<String, dynamic> toDbJson() => {
        "id": id,
        "startContent": startContent,
        "endContent": endContent,
      };




}
