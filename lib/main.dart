import 'dart:convert';

import 'package:al_quran/Models/DaftarSurat.dart';
import 'package:al_quran/Views/Show.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Al-Qur'anku",
  home: MyApp(),
  color: Colors.black87,
));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DaftarSurat daftarSurat = DaftarSurat();
  List<DaftarSurat> listDaftarSurat = [];
  
  Future loadDaftarSurat() {
    Future<List<DaftarSurat>> futureUsers = daftarSurat.all();
    futureUsers.then((response) {
      setState(() {
        listDaftarSurat = response;
      });
    });
    return futureUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Al-Qur'anku"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        child: FutureBuilder(
          future: loadDaftarSurat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListDaftarSurat(daftarSurat: listDaftarSurat);
            } else if (snapshot.hasError) {
              return const Center (
                child: Text('Error'),
              );
            }
            return const CircularProgressIndicator();
          }
        ),
      )
    );
  }
}

class ListDaftarSurat extends StatefulWidget {
  List<DaftarSurat> daftarSurat;

  ListDaftarSurat({Key? key, required this.daftarSurat}) : super(key: key);

  @override
  State<ListDaftarSurat> createState() => _ListDaftarSuratState();
}

class _ListDaftarSuratState extends State<ListDaftarSurat> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.daftarSurat == null ? 0 : widget.daftarSurat.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.black54,
          child: InkWell(
            child: Container(
              // color: Colors.grey,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${widget.daftarSurat[index].id}. ", style: const TextStyle(fontSize: 20.0, color: Colors.white),),
                  Expanded(child: Text("${widget.daftarSurat[index].namaSurat} (${widget.daftarSurat[index].terjemahan})", style: const TextStyle(fontSize: 20.0, color: Colors.white),)),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Show(id: "${widget.daftarSurat[index].id}", namaSurat: "${widget.daftarSurat[index].namaSurat}",)));
            },
          ),
        );
      }
    );
  }
}