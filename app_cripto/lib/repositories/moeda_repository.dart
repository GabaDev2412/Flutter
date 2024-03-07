import 'package:app_cripto/models/moedas.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'images/bitcoin_48px.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 155000.00,
    ),
    Moeda(
      icone: 'images/ethereum-48.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 10220.95,
    ),
    Moeda(
      icone: 'images/litecoin-48.png',
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 339.67,
    ),
    Moeda(
      icone: 'images/cardano-48.png',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 2.83,
    ),
    Moeda(
      icone: 'images/monero-48.png',
      nome: 'Monero',
      sigla: 'XMR',
      preco: 878.89,
    ),
  ];
}
