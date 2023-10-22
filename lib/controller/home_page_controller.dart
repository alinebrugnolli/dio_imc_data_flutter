import 'package:dio_imc_data_flutter/controller/imc_controller.dart';
import 'package:dio_imc_data_flutter/data/db.dart';
import 'package:dio_imc_data_flutter/enums/enums.dart';
import 'package:dio_imc_data_flutter/model/imc_today.dart';
import 'package:dio_imc_data_flutter/model/pessoa.dart';
import 'package:dio_imc_data_flutter/repository/data_repository.dart';
import 'package:flutter/material.dart';

import '../util/math_util.dart';

class HomePageController extends ChangeNotifier {
  late final DataRepository dataRepository;

  HomePageController() {
    _initDataRepository().then((value) => init());
  }

  Future<void> _initDataRepository() async {
    final db = await DB.instance.database;
    dataRepository = DataRepository(db);
  }

  List<ImcToday> _listaImc = [];

  Pessoa _pessoaAtual = Pessoa.empty();

  void init() async {
    debugPrint('init- lançado');
    Pessoa? pessoa = await dataRepository.getPessoa();
    debugPrint(pessoa.toString());
    _listaImc = await dataRepository.getImcTodayList();
    debugPrint(_listaImc.toString());

    if (pessoa != null) {
      _pessoaAtual = pessoa;
      alturaSlider = pessoa.altura;
      pesoSlider = pessoa.peso;
      imc = MathUtil.calcularIMC(pesoSlider, alturaSlider);

      notifyListeners();
    } else {
      await dataRepository.salvarPessoa(_pessoaAtual);
      notifyListeners();
    }
  }

  final TextEditingController nameController = TextEditingController();

  double _alturaSlider = 150;
  set alturaSlider(double altura) {
    _alturaSlider = altura;
  }

  double get alturaSlider => _alturaSlider;

  double _pesoSlider = 50;
  set pesoSlider(double peso) => _pesoSlider = peso;
  double get pesoSlider => _pesoSlider;

  double _imc = 0;

  set imc(double imc) => _imc = imc;
  double get imc => _imc;

  ImcStatus _imcStatus = ImcStatus.saudavel;
  ImcStatus get imcStatus => _imcStatus;
  set imcStatus(ImcStatus imcStatus) => _imcStatus = imcStatus;

  String _imcMessage = ImcController.imcStatusMessage(ImcStatus.saudavel);

  String get imcMessage => _imcMessage;
  set imcMessage(String msg) => _imcMessage = msg;

  String _imcImage = ImcController.imcImage(ImcStatus.saudavel);
  String get imcImage => _imcImage;
  set imcImage(String src) => _imcImage = src;

  void loaderImc() {
    imc = MathUtil.calcularIMC(pesoSlider, alturaSlider);
    imcStatus = ImcController.imcStatus(imc);
    imcMessage = ImcController.imcStatusMessage(imcStatus);
    imcImage = ImcController.imcImage(imcStatus);
    notifyListeners();
    debugPrint(_pessoaAtual.toString());
  }

  void saveImc() {
    loaderImc();

    ImcToday imcToday =
        ImcToday.empty().copyWith(dateTime: DateTime.now(), imc: imc);
    _addListImc(imcToday);
    setPeso(peso: pesoSlider);
    setAltura(altura: alturaSlider);
  }

  String get nome => _pessoaAtual.nome;
  double get peso => _pessoaAtual.peso;
  double get altura => _pessoaAtual.altura;

  List<ImcToday> get getListImc => [..._listaImc];

  void _addListImc(ImcToday imcToday) async {
    if (!_listaImc.contains(imcToday)) {
      dataRepository.salvarImcToday(imcToday);
      _listaImc = await dataRepository.getImcTodayList();
      notifyListeners();
    } else {
      if (imcToday.id != null) {
        dataRepository.updateImcToday(imcToday);
        _listaImc.remove(imcToday);

        _listaImc = await dataRepository.getImcTodayList();
        notifyListeners();
      }
    }
  }

  void removeListImc(int id) async {
    dataRepository.deleteImcToday(id);
    _listaImc = await dataRepository.getImcTodayList();
    notifyListeners();
  }

  void setNome({required String nome}) async {
    await dataRepository.updatePessoa(_pessoaAtual.copyWith(nome: nome));
    init();
  }

  void setPeso({required double peso}) async {
    await dataRepository.updatePessoa(_pessoaAtual.copyWith(peso: peso));

    init();
  }

  void setAltura({required double altura}) async {
    await dataRepository.updatePessoa(_pessoaAtual.copyWith(altura: altura));
    init();
  }
}
