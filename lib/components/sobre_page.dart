import 'package:flutter/material.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Empresa'), automaticallyImplyLeading: false),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 40,
            ),
            const Text(
              'Conheça nossa história',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Stepper(
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  children: <Widget>[],
                );
              },
              currentStep: _index,
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: <Step>[
                Step(
                  isActive: _index == 0,
                  title: const Text('Fundação'),
                  content: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                          'Stellantis, a “supermontadora” surgiu da união da Fiat Chrysler com a Peugeot Citroën. Apesar de não ser ainda familiar para a maioria, O grupo que surge como o quarto maior fabricante de veículos do planeta tem só alguns meses de vida. A nova organização, porém, se impôs de tal forma que as fábricas de cada uma das marcas parecem já pertencer a um novo dono. ')),
                ),
                Step(
                  isActive: _index == 1,
                  title: Text('Administração'),
                  content: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                          'Dirigirão a companhia 45 executivos em posições globais ou regionais. Foram criados nove comitês para a gestão estratégica da empresa, que nasce com receita anual de 167 bilhões de euros, 400 mil funcionários e fábricas em 30 países.')),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Time de Desenvolvedores',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Carlos Andrade Rocha - RM 85384",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Henrique Teixeira Conti - RM 85343",
              style: TextStyle(fontSize: 17),
            )
          ],
        ));
  }
}
