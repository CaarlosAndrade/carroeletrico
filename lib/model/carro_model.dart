import 'package:carroeletrico/model/enum/controle_status.dart';
import 'package:carroeletrico/model/enum/controle_trava.dart';

class Carro {
  int? chassi;
  int? porcentagemCarga;
  int? quilometragem;
  ControleStatus controleStatus;
  ControleTrava controleTrava;
  String apelido;

  Carro(
      {this.chassi,
      this.porcentagemCarga,
      this.quilometragem,
      this.controleStatus = ControleStatus.Desligado,
      this.controleTrava = ControleTrava.Travado,
      required this.apelido});
}
