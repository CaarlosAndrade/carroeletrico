import 'dart:convert';

import 'package:carroeletrico/model/eletropost_model.dart';
import 'package:http/http.dart' as http;

class EletropostoApi {
  final String baseUrl =
      'https://eletroposto20221027133550.azurewebsites.net/api/eletroposto';

  Future<List<Eletroposto>> getListEletroposto() async {
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      var eletropostos = jsonList
          .map<Eletroposto>((json) => Eletroposto.fromJson(json))
          .toList();
      return eletropostos ?? [];
    } else {
      return [];
    }
  }
}
