class Parada {
  String codigoParada;
  String denominacao;
  String endereco;
  double lat;
  double long;

  Parada(
      {this.codigoParada, this.denominacao, this.endereco, this.lat, this.long});

  Parada.fromJson(Map<String, dynamic> parada) {
    codigoParada = parada['codigo'];
    denominacao = parada['denominacao'];
    endereco = parada['endereco'];
    lat = parada['lat'];
    long = parada['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigoParada;
    data['denominacao'] = this.denominacao;
    data['endereco'] = this.endereco;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}