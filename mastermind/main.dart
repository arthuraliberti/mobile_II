// Mastermind - Jogo de lógica em modo texto
// O computador gera uma senha secreta de 4 dígitos (1 a 6) e o jogador tenta adivinhar.

import 'dart:io';
import 'dart:math';

/// Gera a senha secreta de 4 dígitos.
/// Cada dígito é um número entre 1 e 6 (incluindo 1 e 6).
/// REPETIÇÃO PERMITIDA: a senha pode ter dígitos repetidos (ex: 1-2-2-4).
List<int> gerarSenha() {
  final random = Random();
  final senha = <int>[];
  for (var i = 0; i < 4; i++) {
    // nextInt(6) gera 0 a 5, somamos 1 para ficar entre 1 e 6
    senha.add(random.nextInt(6) + 1);
  }
  return senha;
}

/// Lê o palpite do usuário pelo teclado.
/// FORMATO ACEITO: os 4 números em sequência (ex: "1234"). Se o usuário digitar
/// com espaços (ex: "1 2 3 4"), os espaços são removidos antes de validar.
/// Retorna uma lista de 4 inteiros ou null se a entrada for inválida.
List<int>? lerPalpite() {
  final entrada = stdin.readLineSync();
  if (entrada == null || entrada.isEmpty) {
    return null;
  }
  // Remove espaços caso o usuário tenha digitado com espaço por engano
  final texto = entrada.replaceAll(' ', '');
  if (texto.length != 4) {
    return null;
  }
  final palpite = <int>[];
  for (var i = 0; i < 4; i++) {
    final char = texto[i];
    final numero = int.tryParse(char);
    // Cada caractere deve ser um número entre 1 e 6
    if (numero == null || numero < 1 || numero > 6) {
      return null;
    }
    palpite.add(numero);
  }
  return palpite;
}

/// Calcula quantos pinos pretos e quantos pinos brancos o palpite merece.
/// Pino preto: dígito correto na posição correta.
/// Pino branco: dígito existe na senha mas está em outra posição.
/// Não contamos o mesmo dígito duas vezes (ex: senha 1122, palpite 1111 -> 2 pretos, 0 brancos).
void calcularPinos(List<int> senha, List<int> palpite, List<int> resultado) {
  resultado[0] = 0; // pinos pretos
  resultado[1] = 0; // pinos brancos

  // Listas auxiliares para marcar quais posições da senha e do palpite já "couberam" em algum pino
  final senhaUsada = [false, false, false, false];
  final palpiteUsado = [false, false, false, false];

  // Primeiro passada: contar pinos pretos (correto e na posição certa)
  for (var i = 0; i < 4; i++) {
    if (senha[i] == palpite[i]) {
      resultado[0]++;
      senhaUsada[i] = true;
      palpiteUsado[i] = true;
    }
  }

  // Segunda passada: para cada dígito do palpite ainda não usado, ver se existe na senha em posição errada (pino branco)
  for (var p = 0; p < 4; p++) {
    if (palpiteUsado[p]) continue;
    for (var s = 0; s < 4; s++) {
      if (senhaUsada[s]) continue;
      if (senha[s] == palpite[p]) {
        resultado[1]++;
        senhaUsada[s] = true;
        break; // cada dígito do palpite dá no máximo um pino branco
      }
    }
  }
}

void main() {
  print('========================================');
  print('         MASTERMIND - Modo Texto        ');
  print('========================================');
  print('');
  print('Regras:');
  print('- A senha tem 4 dígitos, cada um entre 1 e 6.');
  print('- Digite seu palpite com 4 números em sequência (ex: 1234).');
  print('- Pinos PRETOS: quantidade de números certos na posição certa.');
  print('- Pinos BRANCOS: quantidade de números que existem na senha mas em outra posição.');
  print('- Você tem até 10 tentativas para acertar!');
  print('');

  final senha = gerarSenha();
  const maxTentativas = 10;
  var tentativaAtual = 0;
  var acertou = false;

  // Lista reutilizada para retorno de pinos pretos e brancos
  final resultado = [0, 0];

  while (tentativaAtual < maxTentativas) {
    tentativaAtual++;
    print('--- Tentativa $tentativaAtual de $maxTentativas ---');

    List<int>? palpite;
    do {
      stdout.write('Digite seu palpite (4 números de 1 a 6): ');
      palpite = lerPalpite();
      if (palpite == null) {
        print('Entrada inválida! Use exatamente 4 números, cada um entre 1 e 6 (ex: 1234).');
      }
    } while (palpite == null);

    calcularPinos(senha, palpite, resultado);
    final pretos = resultado[0];
    final brancos = resultado[1];

    print('Palpite: ${palpite.join()} -> Pinos pretos: $pretos, Pinos brancos: $brancos');
    print('');

    if (pretos == 4) {
      acertou = true;
      break;
    }
  }

  print('========================================');
  if (acertou) {
    print('Parabéns! Você acertou a senha em $tentativaAtual tentativa(s)!');
  } else {
    print('Você usou as 10 tentativas. Não desanime, tente novamente!');
  }
  print('A senha era: ${senha.join()}');
  print('========================================');
}
