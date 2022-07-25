import 'package:al_quran/Models/Surat.dart';
import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  final String id, namaSurat;
  const Show({Key? key, required this.id, required this.namaSurat}) : super(key: key);

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  List<Surat> ayat = [];
  
  Future loadDaftarSurat() {
    Future<List<Surat>> futureUsers = Surat(id: widget.id).all();
    futureUsers.then((response) {
      setState(() {
        ayat = response;
      });
    });
    return futureUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id}. ${widget.namaSurat}"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        child: FutureBuilder(
          future: loadDaftarSurat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  cardAyat(
                    nomor: "", 
                    ayat: "\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u0670\u0647\u0650 \u0627\u0644\u0631\u0651\u064e\u062d\u0652\u0645\u0670\u0646\u0650 \u0627\u0644\u0631\u0651\u064e\u062d\u0650\u064a\u0652\u0645\u0650", 
                    terjemahan:"Dengan nama Allah Yang Maha Pengasih, Maha Penyayang."
                  ),
                  for (Surat surat in ayat) 
                    cardAyat(
                      nomor: surat.nomor,
                      ayat: surat.ayat,
                      terjemahan: surat.terjemahan
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center (
                child: Text('Error'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  Card cardAyat({String? nomor, String? ayat, String? terjemahan}) {
    return Card(
      color: Colors.black54,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (nomor != "")
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                "($nomor)", 
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                ayat!, 
                style: const TextStyle(
                  fontSize: 35.0, 
                  fontFamily: 'arabic',
                  height: 2.1,
                  color: Colors.white
                ), 
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            Text(
              terjemahan!, 
              style: const TextStyle(
                fontSize: 15.0,
                height: 1.5,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}