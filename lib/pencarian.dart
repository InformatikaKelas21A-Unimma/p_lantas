import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  bool isChecked = false;
  List<Map<String, dynamic>> searchResults = [];

  Future<void> fetchData() async {
    final url = Uri.parse('http://10.0.2.2/flutter/koneksi.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        searchResults = List.from(jsonData);
      });
    } else {
      // Menangani kesalahan jika koneksi gagal atau permintaan tidak berhasil
      print('Error fetching data from server');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<Map<String, dynamic>> filterResults() {
    if (searchText.isEmpty && !isChecked) {
      return searchResults;
    }

    List<Map<String, dynamic>> filteredList = [];

    for (var item in searchResults) {
      if (isChecked && item['judul'].toLowerCase().contains(searchText.toLowerCase())) {
        filteredList.add(item);
      } else if (!isChecked &&
          (item['judul'].toLowerCase().contains(searchText.toLowerCase()) ||
              item['uu'].toLowerCase().contains(searchText.toLowerCase()) ||
              item['isi'].toLowerCase().contains(searchText.toLowerCase()))) {
        filteredList.add(item);
      }
    }

    return filteredList;
  }

  void showDetailDialog(Map<String, dynamic> law) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${law['uu']} Tentang ${law['tentang']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('-----')),
              Center(child: Text(law['isi'])),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pencarian....',
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filterResults().length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 1.5,
              ),
              itemBuilder: (context, index) {
                final result = filterResults()[index];
                return GestureDetector(
                  onTap: () {
                    showDetailDialog(result);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/peraturan.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(result['judul']),
                    subtitle: Text('${result['uu']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}
