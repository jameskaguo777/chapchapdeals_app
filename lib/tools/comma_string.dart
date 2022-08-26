class CommaString {
  static String toStringWithComma(double number) {
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final String Function(Match) mathFunc = (Match match) => '${match[1]},';

    var stringNumber = number.toString();
    return stringNumber.replaceAllMapped(reg, mathFunc);
  }
}
