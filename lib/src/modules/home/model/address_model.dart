import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  final String? cep;

  @HiveField(1)
  final String? logradouro;

  @HiveField(2)
  final String? bairro;

  @HiveField(3)
  final String? localidade;

  @HiveField(4)
  final String? uf;

  AddressModel(
      {this.cep, this.logradouro, this.bairro, this.localidade, this.uf});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
    );
  }
}
