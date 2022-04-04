class DurationBusinessLogic {
  Duration getAppointmentDuration(String initialHour, String endHour) {
    int intInitialHour = int.parse(initialHour.split(":")[0]);
    int intInitialMinute = int.parse(initialHour.split(":")[1]);
    int intEndHour = int.parse(endHour.split(":")[0]);
    int intEndMinute = int.parse(endHour.split(":")[1]);

    Duration initialHourDuration =
        Duration(hours: intInitialHour, minutes: intInitialMinute);

    Duration endHourDuration =
        Duration(hours: intEndHour, minutes: intEndMinute);

    Duration result = endHourDuration - initialHourDuration;
    return result;
  }

  int getDateTimeDifference(DateTime initialDate, DateTime endDate) {
    int days = endDate.difference(initialDate).inDays;
    return days;
  }
}
