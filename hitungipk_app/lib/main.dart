import 'package:flutter/material.dart';
import 'package:laporan_praktikum6/detail_page.dart';
import 'package:laporan_praktikum6/mahasiswa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Mahasiswa> _mahasiswa = [];

  @override
  void initState() {
    super.initState();
    loadTranskrip().then((value) {
      setState(() {
        _mahasiswa = value;
      });
    });
  }

  double _calculateIPK(Mahasiswa mahasiswa) {
    double totalSKS = 0;
    double totalNilai = 0;

    for (var matkul in mahasiswa.matkul) {
      totalSKS += matkul.sks;
      totalNilai += _nilaiToBobot(matkul.nilai) * matkul.sks;
    }

    return totalNilai / totalSKS;
  }

  double _nilaiToBobot(String nilai) {
    switch (nilai) {
      case 'A':
        return 4.0;
      case 'B':
        return 3.0;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transkrip Mahasiswa"),
      ),
      body: _selectedIndex == 0
          ? _mahasiswa.isNotEmpty
              ? ListView.builder(
                  itemCount: _mahasiswa.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Text(_mahasiswa[index].nim),
                        title: Text(_mahasiswa[index].nama),
                        subtitle: Text(_mahasiswa[index].prodi),
                        trailing: Text(_mahasiswa[index].ip.toStringAsFixed(2)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(mahasiswa: _mahasiswa[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                )
          : _mahasiswa.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'IPK: ${_calculateIPK(_mahasiswa[0]).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(mahasiswa: _mahasiswa[0]),
                            ),
                          );
                        },
                        child: Text('Lihat Detail'),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Detail',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1 && _mahasiswa.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(mahasiswa: _mahasiswa[0]),
              ),
            );
          }
        },
      ),
    );
  }
}
