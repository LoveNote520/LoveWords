class Miss{


  Miss._();
  static Miss? _miss;

  static Miss get instance {
    _miss = _miss ?? Miss._();
    return _miss!;
  }

}