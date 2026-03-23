import 'dart:math';

void main() {
  final random = Random();
  Map<int, Set<int>> jogos = {};

  for (int i = 6; i <= 15; i++) {
    Set<int> volante = {};
    
    while (volante.length < i) {
      volante.add(random.nextInt(60) + 1);
    }
    
    jogos[i] = volante;
  }

  jogos.forEach((tamanho, volante) {
    List<int> volanteOrdenado = volante.toList()..sort();
    print('Aposta com $tamanho números: $volanteOrdenado');
  });
}