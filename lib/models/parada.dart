class Parada {
  String denominacao;
  double lat;
  String endereco;
  double long;
  int codigo;

  Parada({this.denominacao, this.lat, this.endereco, this.long, this.codigo});

  Parada.fromJson(Map<String, dynamic> json) {
    denominacao = json['denominacao'];
    lat = json['lat'];
    endereco = json['endereco'];
    long = json['long'];
    codigo = json['codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['denominacao'] = this.denominacao;
    data['lat'] = this.lat;
    data['endereco'] = this.endereco;
    data['long'] = this.long;
    data['codigo'] = this.codigo;
    return data;
  }
}
