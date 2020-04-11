enum Periods { semana, sabado, domingo }

String label(Periods period) {
  switch (period) {
    case Periods.sabado:
      return "Sábado";
    case Periods.domingo:
      return "Domingo";
    default:
      return "Semana";
  }
}
