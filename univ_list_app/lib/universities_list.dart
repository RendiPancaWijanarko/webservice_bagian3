import 'package:flutter/material.dart';
import 'services/universities_api.dart';

class UniversitiesList extends StatefulWidget {
  @override
  _UniversitiesListState createState() => _UniversitiesListState();
}

class _UniversitiesListState extends State<UniversitiesList> {
  List<dynamic> _universities = [];

  @override
  void initState() {
    super.initState();
    _fetchUniversities();
  }

  Future<void> _fetchUniversities() async {
    try {
      final universities = await UniversitiesApi.fetchUniversities('Indonesia');
      setState(() {
        _universities = universities;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indonesian Universities'),
      ),
      body: _universities.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _universities.length,
              itemBuilder: (context, index) {
                final university = _universities[index];
                return ListTile(
                  title: Text(
                    university['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    university['web_pages'][0],
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
