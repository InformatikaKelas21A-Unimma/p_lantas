import 'package:flutter/material.dart';
import 'package:p_lantas/pencarian.dart';
import 'package:p_lantas/hukum.dart';
import 'package:p_lantas/donasi.dart';
import 'package:p_lantas/info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P-LANTAS',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Feature> features = [
    Feature('assets/images/pencarian.png', 'Pencarian', SearchPage()),
    Feature('assets/images/hnp.png', 'Hukum dan Pasal', LawPage()),
    Feature('assets/images/donasi.png', 'Donasi', DonationPage()),
    Feature('assets/images/info.png', 'Info Aplikasi', InfoPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P-LANTAS'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 160, 143, 123),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 125,
                  height: 125,
                ), // Replace with your logo
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Selamat Datang di Aplikasi P-Lantas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return buildFeatureItem(context, features[index]);
                },
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

  Widget buildFeatureItem(BuildContext context, Feature feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => feature.page),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                feature.imagePath,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8),
              Text(
                feature.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Feature {
  final String imagePath;
  final String title;
  final Widget page;

  Feature(this.imagePath, this.title, this.page);
}