// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class LaboratorioApi extends StatefulWidget {
  const LaboratorioApi({super.key});
  @override
  _LaboratorioApiState createState() => _LaboratorioApiState();
}
class _LaboratorioApiState extends State<LaboratorioApi> {
  final String apiURL = 'https://api.spacexdata.com/v5/launches';
  late Future<List<dynamic>> _data;
  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Mensaje de error, no se, Cyberpunk 2077 lo hizo');
    }
  }
  @override
  Widget build(BuildContext eldenRing) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(230, 0, 0, 8),
        title: const Text(
          'ESPACIO EQUIS',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _data,
        builder: (eldenRing, data) {
          if (data.hasError) {
            return Center(
              child: Text(
                'Sin Datos: ${data.error}'
              )
            );
          } else {
            List<dynamic> Lanzamientos = data.data!;
            return ListView.builder(
              itemCount: Lanzamientos.length,
              itemBuilder: (eldenRing, indice) {
                var idasinvuelta = Lanzamientos[indice];
                String estatus = idasinvuelta['Exito'] == true ? 'Se consiguió' : 'Fracasó';
                return Card(
                  color: Color.fromARGB(230, 184, 184, 248),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (idasinvuelta['links']['patch']['small']!= null)
                        Image.network(
                          idasinvuelta['links']['patch']['small'],
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              idasinvuelta['name'],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text('Fecha: ${idasinvuelta['date_utc']}'),
                            const SizedBox(height: 5),
                            Text('Estado: $estatus'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
