

class Pessoa {
  int id = 0;
  String nome = '';
  double peso = 50;
  double altura = 150;


  Pessoa(
    this.id,
    this.nome,
    this.peso,
    this.altura,
  );

  Pessoa.empty() {
    nome = 'Person01';
    peso = 50;
    altura = 150;
  }


  Pessoa copyWith({
    int? id,
    String? nome,
    double? peso,
    double? altura,
  }) {
    return Pessoa(
      id ?? this.id,
      nome ?? this.nome,
      peso ?? this.peso,
      altura ?? this.altura,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'peso': peso.round(),
      'altura': altura.round(),
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      map['id'],
      map['nome'],
      map['peso'],
      map['altura'],
    );
  }

  @override
  String toString() {
    return 'Pessoa(id: $id, nome: $nome, peso: $peso, altura: $altura)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pessoa && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
