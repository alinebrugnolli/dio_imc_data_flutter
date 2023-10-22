import 'dart:math' as math;

class MathUtil {
  static double calcularIMC(double peso, double altura) {
    altura = altura / 100;
    if (peso < 0.1) throw Exception("O peso deve ser maior que 10 cm!");
    if (altura < .01) throw Exception("A altura deve ser maior que 10 cm!");
    double imc = peso / (math.pow(altura, 2));
    return imc;
  }
}
