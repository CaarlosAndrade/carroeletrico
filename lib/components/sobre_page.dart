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
            title: const Text('Stellantis'), automaticallyImplyLeading: false),
        body: Column(
          children: [
            Stepper(
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => {},
                      child: const Text(''),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: const Text(''),
                    ),
                  ],
                );
              },
              currentStep: _index,
              onStepContinue: () {
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
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
                      child: const Text('Content for Step 1')),
                ),
                Step(
                  isActive: _index == 1,
                  title: Text('Step 2 title'),
                  content: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Content for Step 1')),
                ),
              ],
            ),
            Image(image: image)
          ],
        ));
  }
}
