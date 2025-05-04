import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  Future<List<AddressModel>> _getHistory() async {
    final box = await Hive.openBox<AddressModel>('address_history');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Consultas')),
      body: FutureBuilder<List<AddressModel>>(
        future: _getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Nenhuma consulta realizada ainda.'));
          } else {
            final history = snapshot.data!;
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final address = history[index];
                return ListTile(
                  title: Text('${address.logradouro}, ${address.bairro}'),
                  subtitle: Text('${address.localidade} - ${address.uf}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(address.cep ?? 'CEP'),
                      IconButton(
                        icon: const Icon(Icons.map),
                        tooltip: 'Abrir no Google Maps',
                        onPressed: () async {
                          final query = Uri.encodeComponent(
                            '${address.logradouro}, ${address.bairro}, ${address.localidade} - ${address.uf}',
                          );
                          final url =
                              'https://www.google.com/maps/search/?api=1&query=$query';
                          final uri = Uri.parse(url);

                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Não foi possível abrir o mapa.')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
