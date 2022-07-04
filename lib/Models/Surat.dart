// import 'dart:convert';
// import 'package:http/http.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Surat {
  String? id, nomor, ayat, terjemahan;

  Surat({this.id, this.nomor, this.ayat, this.terjemahan});

  factory Surat.json(Map<String, dynamic> object) {
    return Surat(
      id: object['aya_id'].toString(),
      nomor: object['aya_number'].toString(),
      ayat: (object['aya_text']),
      terjemahan: object['translation_aya_text'],
    );
  }

  Future<List<Surat>> all() async {
    var res = await rootBundle.loadString('data/surat/$id.json');
    List<dynamic> body = jsonDecode(res)['data'];
    List<Surat> surat = body.map((dynamic item) => Surat.json(item)).toList();
    return surat;
  }
}