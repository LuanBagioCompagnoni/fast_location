import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:dio/dio.dart';

part 'address_store.g.dart';

class AddressStore = _AddressStore with _$AddressStore;

abstract class _AddressStore with Store {
  @observable
  AddressModel? address;

  @observable
  bool isLoading = false;

  @observable
  String error = '';

  final Dio dio;

  _AddressStore(this.dio);

  @action
  Future<void> fetchAddress(String cep) async {
    isLoading = true;
    error = '';
    address = null;

    final cleanedCep = cleanCep(cep);

    try {
      final box = await Hive.openBox<AddressModel>('address_history');

      final cachedAddress = box.values.cast<AddressModel?>().firstWhere(
            (address) => cleanCep(address?.cep ?? '') == cleanedCep,
            orElse: () => null,
          );

      if (cachedAddress != null) {
        address = cachedAddress;
        print('🔵 Endereço carregado do cache');
      } else {
        final response =
            await dio.get('https://viacep.com.br/ws/$cleanedCep/json/');

        if (response.statusCode == 200 && response.data != null) {
          if (response.data.containsKey('erro') &&
              response.data['erro'] == true) {
            error = 'Endereço não encontrado';
          } else {
            address = AddressModel.fromJson(response.data);
            await box.add(address!);
            print('🟢 Endereço carregado da API e salvo no cache');
          }
        } else {
          error = 'Endereço não encontrado';
        }
      }
    } catch (e) {
      error = 'Erro na consulta';
      print(e);
    } finally {
      isLoading = false;
    }
  }

  String cleanCep(String cep) {
    return cep.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
