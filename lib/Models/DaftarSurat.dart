// import 'dart:convert';
// import 'package:http/http.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DaftarSurat {
  String? id, namaSurat, teksSurat, terjemahan, jumlahSurat;
  final String uri = "data/daftar-surat.json";

  DaftarSurat({this.id, this.namaSurat, this.teksSurat, this.terjemahan, this.jumlahSurat});

  factory DaftarSurat.json(Map<String, dynamic> object) {
    return DaftarSurat(
      id: object['id'].toString(),
      namaSurat: object['surat_name'],
      teksSurat: object['surat_text'],
      terjemahan: object['surat_terjemahan'],
      jumlahSurat: object['count_ayat'].toString(),
    );
  }

  Future<List<DaftarSurat>> all() async {
    var res = await rootBundle.loadString('data/daftar-surat.json');
    List<dynamic> body = jsonDecode(res)['data'];
    List<DaftarSurat> daftarSurat = body.map((dynamic item) => DaftarSurat.json(item)).toList();
    return daftarSurat;
  }
}