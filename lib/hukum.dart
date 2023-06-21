import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LawPage extends StatefulWidget {
  @override
  _LawPageState createState() => _LawPageState();
}

class _LawPageState extends State<LawPage> {
  List<Map<String, dynamic>> laws = [];

  @override
  void initState() {
    super.initState();
    loadLaws();
  }

  Future<void> loadLaws() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2/flutter/koneksi.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      final db = await openDatabase(
        join(await getDatabasesPath(), 'plantas.db'),
      );
      await db.execute('DELETE FROM hukum_pasal');

      for (var item in jsonResponse) {
        await db.insert('hukum_pasal', item);
      }

      final List<Map<String, dynamic>> results = await db.query('hukum_pasal');

      setState(() {
        laws = results;
      });
    } else {
      print('Error fetching data from server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 160, 143, 123),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'P-LANTAS',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Hukum dan Pasal',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Card(
                  child: ListView.separated(
                    itemCount: laws.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.grey, // Warna garis separator
                      thickness: 1.5, // Ketebalan garis separator
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final law = laws[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/peraturan.png'),
                          backgroundColor: const Color.fromARGB(
                              255, 0, 0, 0), // Warna latar belakang bulatan
                        ),
                        title: Text(law['judul']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${law['uu']} Tentang ${law['tentang']}'),
                          ],
                        ),
                        onTap: () {
                          showLawDetail(context, law);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.brown,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '@P-LANTAS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLawDetail(BuildContext context, Map<String, dynamic> law) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(child: Text(law['judul'])),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text('${law['uu']} Tentang ${law['tentang']}')),
                SizedBox(height: 16.0),
                Center(child: Text('-----')),
                Center(child: Text(law['isi'])),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext)
                    .pop(); // Tutup dialog saat tombol ditekan
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LawPage(),
  ));
}
