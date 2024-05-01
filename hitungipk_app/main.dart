import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transcript IPK'),
        ),
        body: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/transcript.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              var transcript = jsonDecode(snapshot.data.toString());
              double ipk = hitungIPK(transcript);
              return Text(
                'IPK: ${ipk.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              );
            },
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menghitung IPK
  double hitungIPK(Map<String, dynamic> transcript) {
    List<dynamic> mataKuliah = transcript['mahasiswa']['mata_kuliah'];
    double totalSKS = 0;
    double totalBobot = 0;

    for (var matkul in mataKuliah) {
      int sks = matkul['sks'];
      String nilai = matkul['nilai'];
      double bobot = konversiNilai(nilai);

      totalSKS += sks;
      totalBobot += sks * bobot;
    }

    if (totalSKS == 0) {
      return 0;
    } else {
      return totalBobot / totalSKS;
    }
  }

  // Fungsi untuk mengonversi nilai huruf menjadi bobot
  double konversiNilai(String nilai) {
    switch (nilai) {
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }
}
