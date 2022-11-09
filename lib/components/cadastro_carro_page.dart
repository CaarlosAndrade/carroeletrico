import 'package:carroeletrico/model/carro_model.dart';
import 'package:carroeletrico/repository/carro_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroCarroPage extends StatefulWidget {
  Carro? carroParaEdicao;
  CadastroCarroPage({Key? key, this.carroParaEdicao}) : super(key: key);

  @override
  State<CadastroCarroPage> createState() => _CadastroCarroPageState();
}

class _CadastroCarroPageState extends State<CadastroCarroPage> {
  final _nomeController = TextEditingController();
  final _chassiController = TextEditingController();
  final _quilometragemController = TextEditingController();

  final _carroRepository = CarroRepository();

  @override
  void initState() {
    super.initState();

    final carro = widget.carroParaEdicao;

    if (carro != null) {
      _nomeController.text = carro.apelido;
      _chassiController.text = carro.chassi.toString();
      _quilometragemController.text = carro.quilometragem.toString();
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadrastro'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Text(
                  'Registre aqui seus carros em sua garagem virtual',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                _buildApelido(),
                const SizedBox(height: 25),
                _buildChassi(),
                const SizedBox(height: 25),
                _buildQuilometragem(),
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
        border: UnderlineInputBorder(),
        labelText: 'Informe o apelido do seu carro',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o apelido para identificar o veiculo na garagem';
        }
        if (value.length < 2 || value.length > 30) {
          return 'O apelido deve ter entre 2 e 30 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildChassi() {
    return TextFormField(
      controller: _chassiController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Informe o numero do chassi do veiculo',
      ),
      validator: (value) {
        if (value == null || value.length != 17) {
          return 'O chassi deve conter 17 caracteres';
        }
        return null;
      },
      inputFormatters: [
        new LengthLimitingTextInputFormatter(17),
      ],
    );
  }

  TextFormField _buildQuilometragem() {
    return TextFormField(
      controller: _quilometragemController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Informe a quilometragem atual',
      ),
    );
  }

  SizedBox _buildBotao() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Registrar carro no sistema'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final apelido = _nomeController.text;
            final quilometragem = _quilometragemController.text;
            final chassi = int.parse(_chassiController.text);

            _nomeController.clear();
            _quilometragemController.clear();
            _chassiController.clear();
            final carro = Carro(
                apelido: apelido,
                chassi: chassi,
                quilometragem: int.parse(quilometragem),
                porcentagemCarga: 100);

            try {
              if (widget.carroParaEdicao != null) {
                await _carroRepository.atualizarCarro(carro);
              } else {
                await _carroRepository.cadastrarCarro(carro);
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$apelido cadastrado com sucesso'),
              ));
            } catch (e) {
              Navigator.of(context).pop(false);
            }
          }
        },
      ),
    );
  }
}
