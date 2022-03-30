class Pacient {
  final String name, lastName, id;
  final String? rg,
      cpf,
      birthDay,
      nacionalidade,
      sexo,
      telefone,
      celular,
      estadoCivil,
      profissao,
      enderecoResidencial,
      enderecoProfissional,
      orgaoExpedidor,
      indicadoPor;

  Pacient({
    required this.name,
    required this.lastName,
    required this.id,
    this.birthDay,
    this.rg,
    this.cpf,
    this.nacionalidade,
    this.sexo,
    this.telefone,
    this.celular,
    this.estadoCivil,
    this.profissao,
    this.enderecoResidencial,
    this.enderecoProfissional,
    this.orgaoExpedidor,
    this.indicadoPor,
  });

  factory Pacient.fromJson(Map<String, dynamic> json) {
    return Pacient(
        name: json['name'],
        lastName: json['lastName'],
        birthDay: json['birthDay'],
        id: json['id'],
        rg: json['rg'],
        nacionalidade: json['nacionalidade'],
        sexo: json['sexo'],
        telefone: json['telefone'],
        celular: json['celular'],
        estadoCivil: json['estadoCivil'],
        profissao: json['profissao'],
        enderecoResidencial: json['enderecoResidencial'],
        enderecoProfissional: json['enderecoProfissional'],
        orgaoExpedidor: json['orgaoExpedidor'],
        indicadoPor: json['indicadoPor']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'birthDay': birthDay,
        'id': id,
        'rg': rg,
        'cpf': cpf,
        'nacionalidade': nacionalidade,
        'sexo': sexo,
        'telefone': telefone,
        'celular': celular,
        'estadoCivil': estadoCivil,
        'profissao': profissao,
        'enderecoResidencial' : enderecoResidencial,
        'enderecoProfissional' : enderecoProfissional,
        'orgaoExpedidor': orgaoExpedidor,
        'indicadoPor': indicadoPor
      };
}
