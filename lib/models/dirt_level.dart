class DirtLevel {
  double _small;
  double _medium;
  double _large;
  double _value;

  DirtLevel({double x}) {
    _value = x;
    if (x <= 50) {
      this._small = 1 - x / 50.0;
      this._medium = x / 50.0;
      this._large = 0;
    } else if (x <= 100) {
      this._small = 0;
      this._medium = 2 - x / 50.0;
      this._large = x / 50.0 - 1;
    }
  }

  double get getSmall => this._small;
  double get getMedium => this._medium;
  double get getLarge => this._large;

  @override
  String toString() {
    // TODO: implement toString
    return '{x: $_value, Small: $getSmall, Medium: $getMedium, Large: $getLarge}';
  }
}
