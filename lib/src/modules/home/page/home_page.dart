import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fast_location/src/modules/home/controller/address_store.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addressStore = Provider.of<AddressStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Ver histórico',
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Digite o CEP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final cep = _controller.text.trim();
                if (cep.length == 8) {
                  addressStore.fetchAddress(cep);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('CEP inválido')),
                  );
                }
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            Observer(
              builder: (_) {
                if (addressStore.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (addressStore.error.isNotEmpty) {
                  return Center(
                    child: Text(
                      addressStore.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (addressStore.address?.cep != null) {
                  return _buildAddress(addressStore.address!);
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddress(AddressModel address) {
    final fullAddress =
        '${address.logradouro}, ${address.bairro}, ${address.localidade}, ${address.uf}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CEP: ${address.cep}'),
        Text('Logradouro: ${address.logradouro}'),
        Text('Bairro: ${address.bairro}'),
        Text('Localidade: ${address.localidade}'),
        Text('UF: ${address.uf}'),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () async {
            final encodedAddress = Uri.encodeComponent(fullAddress);
            final url =
                'https://www.google.com/maps/dir/?api=1&destination=$encodedAddress';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Não foi possível abrir o Google Maps')),
              );
            }
          },
          icon: const Icon(Icons.map),
          label: const Text('Traçar rota no Google Maps'),
        ),
      ],
    );
  }
}
