import 'dart:convert';
import 'package:al_quran/Models/Surat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserService {
  final String uri = "https://reqres.in/api/users";
  
  Future<List<Surat>> all() async {
    var res = await rootBundle.loadString('data/surat/1.json');
    List<dynamic> body = jsonDecode(res)['data'];
    List<Surat> surat = body.map((dynamic item) => Surat.json(item)).toList();
    return surat;
  }
}