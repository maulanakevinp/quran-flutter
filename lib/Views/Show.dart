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
              return ListDaftarAyat(surat: ayat);
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
}

class ListDaftarAyat extends StatelessWidget {
  List<Surat> surat;

  ListDaftarAyat({Key? key, required this.surat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: surat == null ? 0 : surat.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.black54,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container
                  (margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "(${surat[index].nomor})", 
                    style: const TextStyle(
                      fontSize: 18.0,
                      // fontFamily: 'arabic',
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "${surat[index].ayat}", 
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
                  "${surat[index].terjemahan}", 
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
    );
  }
}