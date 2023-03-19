import 'dart:io';
import 'dart:math';

class CifraDeVigenere {
  String _chave = '';

  String gerarChave(String texto) {
    int tamanho = texto.length;
    final random = Random();
    for (int i = 0; i < tamanho; i++) {
      _chave += String.fromCharCode(random.nextInt(26) + 65);
    }
    return _chave;
  }

  String encode(String texto) {
    String textoMaiusculo = texto.toUpperCase();
    String resultado = "";
    int tamanhoTexto = textoMaiusculo.length;
    int tamanhoChave = _chave.length;

    for (int i = 0; i < tamanhoTexto; i++) {
      int charCodeTexto = textoMaiusculo.codeUnitAt(i);
      int charCodeChave = _chave.codeUnitAt(i % tamanhoChave);

      if (charCodeTexto >= 65 && charCodeTexto <= 90) {
        int novoCharCode = ((charCodeTexto + charCodeChave) % 26) + 65;
        resultado += String.fromCharCode(novoCharCode);
      } else {
        resultado += textoMaiusculo[i];
      }
    }

    return resultado;
  }

  String decode(String texto) {
    String resultado = '';
    for (int i = 0; i < texto.length; i++) {
      int charDescriptografado =
          ((texto.codeUnitAt(i) - _chave.codeUnitAt(i % _chave.length)) + 26) %
                  26 +
              65;
      resultado += String.fromCharCode(charDescriptografado);
    }
    return resultado;
  }

  String get chave => _chave;
}

void main() {
  int i = 0;
  while (i < 10) {
    print('Digite um Texto a ser criptografado: ');
    String texto = stdin.readLineSync()!;
    texto = texto.replaceAll(RegExp('[^a-zA-Z]+'), '').toUpperCase();

    CifraDeVigenere cripto = CifraDeVigenere();
    String chave = cripto.gerarChave(texto);
    String textoCriptografado = cripto.encode(texto);
    String textoDescriptografado = cripto.decode(textoCriptografado);

    print('Texto original: $texto');
    print('Chave: $chave');
    print('Texto criptografado: $textoCriptografado');
    print('Texto descriptografado: $textoDescriptografado\n');
    i++;
  }
}
