class MissMember {
  int time; //时间戳
  int missCount;
  String name;
  String word;

  MissMember({
    required this.time,
    required this.missCount,
    required this.name,
    required this.word,
  });

  Map<String, dynamic> toMap() => {
        "time": time,
        "missCount": missCount,
        "name": name,
        "word": word,
      };

  factory MissMember.formMap(Map<String, dynamic> map) {
    return MissMember(
        time: map["time"],
        missCount: map["missCount"],
        name: map["name"],
        word: map["word"]);
  }
}
