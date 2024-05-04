import 'package:app_cripto/models/moedas.dart';
import 'package:app_cripto/repositories/favoritas_repository.dart';
import 'package:app_cripto/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../configs/app_settings.dart';

class MoedasDetalhesPage extends StatefulWidget {
  Moeda moeda;

  MoedasDetalhesPage({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> favoritada = [];
  late FavoritasRepository favoritas;
  late MoedaRepository moeda;
  final tabela = MoedaRepository.tabela;
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  @override
  Widget build(BuildContext context) {
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.moeda.nome),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  title: const Text('Adicionar as favoritas'),
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<FavoritasRepository>(context, listen: false)
                        .adiciona(widget.moeda);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: const Text('Remover das favoritas'),
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<FavoritasRepository>(context, listen: false)
                        .remove(widget.moeda);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(widget.moeda.icone),
                  width: 50,
                ),
                Container(width: 10),
                Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          (quantidade > 0)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      '$quantidade ${widget.moeda.sigla}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                )
              : Container(margin: const EdgeInsets.only(top: 5)),
          Form(
            key: _form,
            child: TextFormField(
              controller: _valor,
              style: const TextStyle(
                fontSize: 22,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor',
                prefixIcon: Icon(Icons.monetization_on_outlined),
                suffix: Text(
                  'reais',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe o valor da compra';
                } else if (double.parse(value) < 50) {
                  return 'Compra mínima é R\$ 50,00';
                }
                return null;
              },
              onChanged: (value) => setState(() {
                quantidade = (value.isEmpty)
                    ? 0
                    : double.parse(value) / widget.moeda.preco;
              }),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 25),
            child: ElevatedButton(
              onPressed: () => comprar(),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Comprar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  comprar() {
    if (_form.currentState!.validate()) {
      // salvar a compra

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compra realizada com sucesso!')));
    }
  }
}
