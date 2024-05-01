import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Mahasiswa {
  final String nim;
  final String nama;
  final String prodi;
  final int semester;
  final double ip;
  final List<MataKuliah> matkul;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.semester,
    required this.ip,
    required this.matkul,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw ArgumentError("Received null JSON data");
    List<MataKuliah> matkulList = [];
    for (var item in json['matkul']) {
      matkulList.add(MataKuliah.fromJson(item));
    }
    return Mahasiswa(
      nim: json['nim'],
      nama: json['nama'],
      prodi: json['prodi'],
      semester: json['semester'],
      ip: json['ip'],
      matkul: matkulList,
    );
  }
}

class MataKuliah {
  final String kode;
  final String nama;
  final int sks;
  final String nilai;

  MataKuliah({
    required this.kode,
    required this.nama,
    required this.sks,
    required this.nilai,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      kode: json['kode'],
      nama: json['nama'],
      sks: json['sks'],
      nilai: json['nilai'],
    );
  }
}

Future<List<Mahasiswa>> loadTranskrip() async {
  try {
    String jsonString = await rootBundle.loadString('assets/transkrip.json');
    List<dynamic> data = jsonDecode(jsonString);
    List<Mahasiswa> mahasiswas =
        data.map((e) => Mahasiswa.fromJson(e)).toList();
    return mahasiswas;
  } catch (e) {
    print("Error loading transkrip: $e");
    return [];
  }
}