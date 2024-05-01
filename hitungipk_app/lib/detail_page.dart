import 'package:flutter/material.dart';
import 'mahasiswa.dart';

class DetailPage extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const DetailPage({Key? key, required this.mahasiswa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mahasiswa.nama),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NIM: ${mahasiswa.nim}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Prodi: ${mahasiswa.prodi}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Semester: ${mahasiswa.semester}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'IP: ${mahasiswa.ip}',
              style: TextStyle(fontSize: 18),
            ),
            ...mahasiswa.matkul.map((matkul) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${matkul.kode} - ${matkul.nama}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'SKS: ${matkul.sks}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Nilai: ${matkul.nilai}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
