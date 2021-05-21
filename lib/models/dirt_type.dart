class DirtType {
  double _notGreasy;
  double _medium;
  double _greasy;
  double _value;

  DirtType({double y}) {
    _value = y;
    if (y <= 50) {
      this._notGreasy = 1 - y / 50.0;
      this._medium = y / 50.0;
      this._greasy = 0;
    } else if (y <= 100) {
      this._notGreasy = 0;
      this._medium = 2 - y / 50.0;
      this._greasy = y / 50.0 - 1;
    }
  }

  double get getNotGreasy => this._notGreasy;
  double get getMedium => this._medium;
  double get getGreasy => this._greasy;

  @override
  String toString() {
    // TODO: implement toString
    return '{y: $_value, NotGreasy: $getNotGreasy, Medium: $getMedium, Greasy: $getGreasy}';
  }
}
