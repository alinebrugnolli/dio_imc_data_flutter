import 'package:dio_imc_data_flutter/enums/enums.dart';

class ImcController {
  static ImcStatus imcStatus(double imc) => switch (imc) {
        < 16 => ImcStatus.magrezaGrave,
        >= 16 && < 17 => ImcStatus.magrezaModerada,
        >= 17 && < 18.5 => ImcStatus.magrezaLeve,
        >= 18.5 && < 25 => ImcStatus.saudavel,
        >= 25 && < 30 => ImcStatus.sobrepeso,
        >= 30 && < 35 => ImcStatus.sobrepesoGrau_1,
        >= 35 && < 40 => ImcStatus.obesidadeGrau_2,
        > 40 => ImcStatus.obesidadeGrau_3,
        _ => ImcStatus.nan,
      };

  static String imcStatusMessage(ImcStatus imcStatus) => switch (imcStatus) {
        ImcStatus.magrezaGrave => 'Magreza Grave',
        ImcStatus.magrezaModerada => 'Magreza  Moderada',
        ImcStatus.magrezaLeve => 'Magreza Leve',
        ImcStatus.saudavel => 'Saudável',
        ImcStatus.sobrepeso => 'Sobrepeso',
        ImcStatus.sobrepesoGrau_1 => 'Sobrepeso Grau 1',
        ImcStatus.obesidadeGrau_2 => 'Obesidade Grau 2 (Severa) ',
        ImcStatus.obesidadeGrau_3 => 'Obesidade Grau 3 (Mórbida)',
        ImcStatus.nan => 'Não foi possível obter o status do IMC',
      };

  static String imcImage(ImcStatus imcStatus) {
    String baseUrl(String str) => 'imgs/$str.svg';

    return switch (imcStatus) {
      ImcStatus.magrezaGrave => baseUrl('magrezaGrave'),
      ImcStatus.magrezaModerada => baseUrl('magrezaModerada'),
      ImcStatus.magrezaLeve => baseUrl('magrezaLeve'),
      ImcStatus.saudavel || ImcStatus.nan => baseUrl('saudavel'),
      ImcStatus.sobrepeso => baseUrl('sobrepeso'),
      ImcStatus.sobrepesoGrau_1 => baseUrl('sobrepesoGrau_1'),
      ImcStatus.obesidadeGrau_2 => baseUrl('obesidadeGrau_2'),
      ImcStatus.obesidadeGrau_3 => baseUrl('obesidadeGrau_3')
    };
  }
}
