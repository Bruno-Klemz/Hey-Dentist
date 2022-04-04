class DateTimeBusinessLogic {
  String getNamedMonth(int month) {
    List<String> namedMonthList = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    return namedMonthList[month - 1];
  }
}