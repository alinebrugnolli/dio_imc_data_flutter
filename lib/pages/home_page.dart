
import 'package:dio_imc_data_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;

  @override
  void initState() {
    super.initState();
    homePageController = context.read<HomePageController>();
  }

  @override
  Widget build(BuildContext context) {
    homePageController = context.watch<HomePageController>();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.cyan,
                      child: createImgImc(
                        image: homePageController.imcImage,
                      ),
                    ),
                    accountName: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [                        
                        Text('Nome: ${homePageController.nome}',style: const TextStyle(color: Colors.black),),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_rounded,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    accountEmail: null),
              ),
              Expanded(
                  child: ListView(
                      children: homePageController.getListImc
                          .map(
                            (imcItem) =>
                                createItemImcList(UniqueKey(), imcItem),
                          )
                          .toList()))
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Calculadora de IMC"),
          backgroundColor: Colors.deepPurpleAccent,
          titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text('Nome: ${homePageController.pessoaAtual?.nome}'),
                  Text('IMC: ${homePageController.imc.round()}'),
                ],
              ),
            ),

            //
            Expanded(
              flex: 4,
              child: Container(
                child: Stack(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      height: 60,
                      width: double.infinity,
                      // color: Colors.orange,
                      padding: const EdgeInsets.all(10),
                      child: Text('Status: ${homePageController.imcMessage}')),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 3),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 3),
                                child: createImgImc(
                                    image: homePageController.imcImage),
                              ),
                            ),
                          )),
                      Expanded(
                          child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                  "Altura: ${homePageController.alturaSlider.round() / 100}"),
                            ),
                            Expanded(
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Card(
                                  elevation: 3,
                                  child: Slider(
                                    value: homePageController.alturaSlider,
                                    min: 10,
                                    max: 400.0,
                                    onChanged: (value) {
                                      homePageController.alturaSlider = value;
                                      homePageController.loaderImc();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ]),
              ),
            ),
            //
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          "Peso: ${homePageController.pesoSlider.round()}"),
                    ),
                    Card(
                      child: Container(
                          child: Slider(
                        value: homePageController.pesoSlider,
                        min: 10,
                        max: 400.0,
                        onChanged: (value) {
                          homePageController.pesoSlider = value;
                          homePageController.loaderImc();
                        },
                      )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        homePageController.saveImc();
                      },
                      child: const Text('Salvar',style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
