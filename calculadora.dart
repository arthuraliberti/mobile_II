import 'dart:math';

void main() {
  Map<String, Function(List<double>)> calculadora = {
    'raizes': calcularRaizes,
    'soma': (args) => print('Soma: ${args.reduce((a, b) => a + b)}'),
  };

  executar(calculadora, 'raizes', [1, -5, 6]); 
  executar(calculadora, 'raizes', [2, -8]);    
  executar(calculadora, 'soma', [10, 20]);     
}

void executar(Map<String, Function(List<double>)> calc, String nomeFuncao, List<double> parametros) {
  if (calc.containsKey(nomeFuncao)) {
    calc[nomeFuncao]!(parametros);
  } else {
    print("Função '$nomeFuncao' não encontrada.");
  }
}

void calcularRaizes(List<double> p) {
  if (p.length == 2) {
    double b = p[0];
    double c = p[1];

    if (b == 0) {
      print('Equação de 1º grau inválida (b = 0).');
    } else {
      double raiz = -c / b;
      print('Equação de 1º grau detectada. Raiz: x = $raiz');
    }
  } else if (p.length == 3) {
    double a = p[0];
    double b = p[1];
    double c = p[2];

    if (a == 0) {
      print('Se a=0, não é equação de 2º grau. Use 2 parâmetros.');
      return;
    }

    double delta = pow(b, 2) - (4 * a * c);
    print('Equação de 2º grau detectada.');

    if (delta < 0) {
      print('Não possui raízes reais (Delta < 0).');
    } else if (delta == 0) {
      double raiz = -b / (2 * a);
      print('Possui uma raiz real: x = $raiz');
    } else {
      double x1 = (-b + sqrt(delta)) / (2 * a);
      double x2 = (-b - sqrt(delta)) / (2 * a);
      print('Possui duas raízes reais: x1 = $x1 | x2 = $x2');
    }
  } else {
    print('Erro: Passe 2 parâmetros (b, c) ou 3 parâmetros (a, b, c).');
  }
}
