class LoveStoryWords {
  final int id;
  final int createAt;
  final String startContent;
  final String? endContent;

  const LoveStoryWords({
    required this.id,
    this.endContent,
    required this.startContent,
    required this.createAt,
  });

  Map<String, dynamic> toDbJson() => {
        "id": id,
        "startContent": startContent,
        if (endContent != null) "endContent": endContent,
        "create_at": createAt,
      };

  factory  LoveStoryWords.fromMap(Map<String, dynamic> map) {
    return LoveStoryWords(
        id:int.parse( map["id"]) ,
        startContent: map["startContent"] ?? '',
        endContent: map["endContent"],
        createAt: map["createAt"] ?? 0);
  }
}
