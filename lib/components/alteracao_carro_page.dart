import 'dart:convert';

import 'package:carroeletrico/components/lista_carro_page.dart';
import 'package:carroeletrico/model/carro_model.dart';
import 'package:carroeletrico/model/enum/controle_status.dart';
import 'package:carroeletrico/model/enum/controle_trava.dart';
import 'package:carroeletrico/repository/carro_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlteracaoCarroPage extends StatefulWidget {
  Carro? carroParaEdicao;
  AlteracaoCarroPage({Key? key, this.carroParaEdicao}) : super(key: key);

  @override
  State<AlteracaoCarroPage> createState() => _AlteracaoCarroPageState();
}

class _AlteracaoCarroPageState extends State<AlteracaoCarroPage> {
  final _nomeController = TextEditingController();
  final _chassiController = TextEditingController();
  final _quilometragemController = TextEditingController();

  ControleStatus controleStatusChaveEletronica = ControleStatus.Desligado;
  ControleTrava controleTrava = ControleTrava.Destravado;

  final _carroRepository = CarroRepository();

  @override
  void initState() {
    super.initState();

    final carro = widget.carroParaEdicao;

    _nomeController.text = carro!.apelido;
    _chassiController.text = carro.chassi.toString();
    _quilometragemController.text = carro.quilometragem.toString();
    controleStatusChaveEletronica = carro.controleStatus;
    controleTrava = carro.controleTrava;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Atualização'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Text(
                  'Faça a atualização dos dados do seu carro',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                _buildApelido(),
                const SizedBox(height: 25),
                _buildQuilometragem(),
                const SizedBox(height: 25),
                const Text(
                  'Controle seu carro de forma remota',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                _buildChaveEletronica(),
                const SizedBox(height: 25),
                _buildTravaDestrava(),
                const SizedBox(height: 25),
                _buildBotao()
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildApelido() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
          hintText: 'Informe o apelido do seu carro',
          labelText: 'Apelido:',
          prefixIcon: Icon(Icons.time_to_leave),
          border: OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o apelido para identificação';
        }
        if (value.length < 5 || value.length > 30) {
          return 'O apelido deve ter entre 5 e 30 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildQuilometragem() {
    return TextFormField(
      controller: _quilometragemController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
          hintText: 'Informe a quilometragem',
          labelText: 'Quilometragem:',
          prefixIcon: Icon(Icons.time_to_leave),
          border: OutlineInputBorder()),
    );
  }

  SizedBox _buildBotao() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Aplicar atualização'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final apelido = _nomeController.text;
            final quilometragem = _quilometragemController.text;
            final chassi = int.parse(_chassiController.text);

            final carro = Carro(
                apelido: apelido,
                chassi: chassi,
                quilometragem: int.parse(quilometragem),
                controleStatus: controleStatusChaveEletronica,
                controleTrava: controleTrava);

            try {
              await _carroRepository.atualizarCarro(carro);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$apelido alterado com sucesso'),
              ));
              Navigator.pop(context);
            } catch (e) {
              Navigator.of(context).pop(false);
            }
          }
        },
      ),
    );
  }

  Widget _buildChaveEletronica() {
    return Column(
      children: <Widget>[
        RadioListTile<ControleStatus>(
          title: const Text('Carro Desligado'),
          value: ControleStatus.Desligado,
          groupValue: controleStatusChaveEletronica,
          onChanged: (ControleStatus? value) {
            if (value != null) {
              setState(() {
                controleStatusChaveEletronica = value;
              });
            }
          },
        ),
        RadioListTile<ControleStatus>(
          title: const Text('Carro Ligado'),
          value: ControleStatus.Ligado,
          groupValue: controleStatusChaveEletronica,
          onChanged: (ControleStatus? value) {
            if (value != null) {
              setState(() {
                controleStatusChaveEletronica = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildTravaDestrava() {
    return Column(
      children: <Widget>[
        RadioListTile<ControleTrava>(
          title: const Text('Carro Travado'),
          value: ControleTrava.Travado,
          groupValue: controleTrava,
          onChanged: (ControleTrava? value) {
            if (value != null) {
              setState(() {
                controleTrava = value;
              });
            }
          },
        ),
        RadioListTile<ControleTrava>(
          title: const Text('Carro Destravado'),
          value: ControleTrava.Destravado,
          groupValue: controleTrava,
          onChanged: (ControleTrava? value) {
            if (value != null) {
              setState(() {
                controleTrava = value;
              });
            }
          },
        ),
      ],
    );
  }
}
