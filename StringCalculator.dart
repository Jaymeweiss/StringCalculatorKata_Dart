class StringCalculator {
  static int sum(String input) {
    if (input.isEmpty) {
      return 0;
    } else {
      return _getNumbers(input).reduce((a, b) => a + b);
    }
  }

  static Iterable<int> _getNumbers(String input) {
    Match piecesMatch = new RegExp("//(.*)\n(.*)").firstMatch(input);

    var numbersList = _getNumbersString(piecesMatch, input)
        .split(_getRegex(piecesMatch))
        .map((element) => int.parse(element))
        .where((element) => element < 1001);

    _handleNegativeNumbers(numbersList);

    return numbersList;
  }

  static void _handleNegativeNumbers(Iterable<int> numbersList) {
    var negativeNumbers = numbersList.where((element) => element < 0);
    if (negativeNumbers.length > 0) {
      throw new FormatException(
          "Negatives are not allowed: ${negativeNumbers.join(", ")}");
    }
  }

  static RegExp _getRegex(Match piecesMatch) {
    RegExp regex = RegExp("(,)|(\n)");
    if (piecesMatch != null) {
      return RegExp(_getDelimiterString(piecesMatch.group(1)));
    }
    return regex;
  }

  static String _getDelimiterString(String roughDelimiters) {
    Match delimiters = new RegExp("\\[(.*)\\]").firstMatch(roughDelimiters);
    if (delimiters != null) {
      return "(" +
          delimiters
              .group(1)
              .split("\]\[")
              .map((element) => _quoteDelimiter(element))
              .join(")|(") +
          ")";
    } else {
      return _quoteDelimiter(roughDelimiters);
    }
  }

  static String _quoteDelimiter(String delimiter) {
    var buffer = new StringBuffer();
    for (var i = 0; i < delimiter.length; i++) {
      buffer.write("\\");
      buffer.write(delimiter[i]);
    }
    return buffer.toString();
  }

  static String _getNumbersString(Match piecesMatch, String input) {
    if (piecesMatch != null) {
      return piecesMatch.group(2);
    } else {
      return input;
    }
  }
}
