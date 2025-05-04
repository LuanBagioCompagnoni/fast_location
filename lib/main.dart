import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fast_location/src/modules/home/controller/address_store.dart';
import 'package:fast_location/src/modules/home/page/home_page.dart';
import 'package:fast_location/src/modules/history/page/history_page.dart';
import 'package:fast_location/src/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AddressModelAdapter());
  await Hive.openBox<AddressModel>('address_history');

  runApp(const FastLocationApp());
}

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastLocation',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => Provider(
              create: (_) => AddressStore(Dio()),
              child: const HomePage(),
            ),
        AppRoutes.history: (context) => const HistoryPage(),
      },
    );
  }
}
