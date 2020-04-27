enum Periods { semana, sabado, domingo }

Periods getPeriodFromWeekday(int weekday) {
  switch (weekday) {
    case 7:
      return Periods.domingo;
    case 6:
      return Periods.sabado;
    default:
      return Periods.semana;
  }
}
