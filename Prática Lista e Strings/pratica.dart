import 'dart:io';

void main() {
  // 1 - Conversão de Data por Extenso
  print('--- Exercício 1 ---');
  stdout.write('Digite a data (dd/mm/aaaa): ');
  String? dataInput = stdin.readLineSync();
  if (dataInput != null && dataInput.contains('/')) {
    List<String> partes = dataInput.split('/');
    List<String> meses = [
      '', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    int mes = int.parse(partes[1]);
    print('${partes[0]} de ${meses[mes]} de ${partes[2]}');
  }

  // 2 - Contagem de Elementos Repetidos
  print('\n--- Exercício 2 ---');
  List<int> numeros = [];
  Map<int, int> frequencia = {};
  for (int i = 0; i < 10; i++) {
    stdout.write('Digite o ${i + 1}º número inteiro: ');
    int n = int.parse(stdin.readLineSync()!);
    numeros.add(n);
    frequencia[n] = (frequencia[n] ?? 0) + 1;
  }
  frequencia.forEach((valor, qtd) {
    print('Valor $valor: aparece $qtd vez(es)');
  });

  // 3 - Comparação de Listas
  print('\n--- Exercício 3 ---');
  List<int> preencherLista(int ordem) {
    List<int> lista = [];
    while (true) {
      stdout.write('Lista $ordem - Digite um número (0 para parar): ');
      int valor = int.parse(stdin.readLineSync()!);
      if (valor == 0) break;
      lista.add(valor);
    }
    return lista;
  }

  List<int> listaA = preencherLista(1);
  List<int> listaB = preencherLista(2);

  if (listaA.length > listaB.length) {
    print('A primeira lista é maior que a segunda.');
  } else if (listaA.length < listaB.length) {
    print('A primeira lista é menor que a segunda.');
  } else {
    print('As listas possuem o mesmo tamanho.');
    listaA.sort();
    listaB.sort();
    bool identicas = true;
    for (int i = 0; i < listaA.length; i++) {
      if (listaA[i] != listaB[i]) {
        identicas = false;
        break;
      }
    }
    print(identicas ? 'As listas são idênticas.' : 'As listas não são idênticas.');
  }
}