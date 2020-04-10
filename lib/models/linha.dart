class Linha {
  String codigoLinha;
  String denomicao;
  String origem;
  String retorno;
  bool circular;

  Linha(
      {this.codigoLinha,
        this.denomicao,
        this.origem,
        this.retorno,
        this.circular});

  Linha.fromJson(Map<String, dynamic> json) {
    codigoLinha = json['CodigoLinha'];
    denomicao = json['Denomicao'];
    origem = json['Origem'];
    retorno = json['Retorno'];
    circular = json['Circular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CodigoLinha'] = this.codigoLinha;
    data['Denomicao'] = this.denomicao;
    data['Origem'] = this.origem;
    data['Retorno'] = this.retorno;
    data['Circular'] = this.circular;
    return data;
  }
}
