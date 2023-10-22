import 'package:dio_imc_data_flutter/controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageController>(
            create: (ctx) => HomePageController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          colorScheme: const ColorScheme.light(),
        ),
        title: 'Calculadora de IMC',
        home: const HomePage(),
      ),
    );
  }
}
