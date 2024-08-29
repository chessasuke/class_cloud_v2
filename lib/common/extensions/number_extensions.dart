import 'dart:math';

extension IntX on int {
  /// Returns value in the range [rangeMin] <= this <= [rangeMax]. So, returns [rangeMin] if value is less than
  /// [rangeMin], returns [rangeMax] if value is greater than [rangeMax], returns value otherwise.
  int toRange(int rangeMin, int rangeMax) => min(max(rangeMin, this), rangeMax);

  static int? hexStringToInt(String hex) {
    return int.tryParse(hex, radix: 16);
  }

  static int? getIntFromNum(Object? number) {
    if (number is num) {
      return number.round();
    }
    return null;
  }
}

extension DoubleX on double {
  double roundToNDecimalPlaces([int decimalPlaces = 2]) {
    return ((this * pow(10, decimalPlaces)).round()) / pow(10, decimalPlaces);
  }

  String toPercentageString() {
    return '${(roundToNDecimalPlaces() * 100).round()}%';
  }
}

extension ListNumX on List<num> {
  double get min {
    if (isEmpty) throw (Exception('List cannot be empty'));
    return reduce((value, element) => value > element ? element : value)
        .toDouble();
  }

  double get max {
    if (isEmpty) throw (Exception('List cannot be empty'));
    return reduce((value, element) => value < element ? element : value)
        .toDouble();
  }
}
