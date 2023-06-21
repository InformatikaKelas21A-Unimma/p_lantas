import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 160, 143, 123),
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
            color: Color.fromARGB(255, 160, 143, 123),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'INFO APLIKASI',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(255, 160, 143, 123),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Informasi Aplikasi',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Aplikasi ini berisi tentang hukum pidana berkendara dan berisi sanksi yang diterima oleh pelanggar.',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Dengan aplikasi ini pelanggar juga dapat belajar tentang hukum berkendara yang baik dan benar.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Informasi Programmer',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _launchURL('https://pddikti.kemdikbud.go.id/data_mahasiswa/REVCNEE5QUItMDdFNC00ODlELUFFMzktMDEwMkI4OEE1MzdG');
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Zulfa Fadhliyati Muna\n21.0504.0007',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            _launchURL('https://pddikti.kemdikbud.go.id/data_mahasiswa/MTExOEQxRDMtMkJDNy00MjYzLUJCODEtNjk0N0YxMDg1N0Ix');
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Rafly Ferraldinand Syach\n21.0504.0018',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            _launchURL('https://pddikti.kemdikbud.go.id/data_mahasiswa/NkFEMzAwM0MtM0UyOC00QUE3LUI2NTUtMTFCMUY0NjQ5N0Yy');
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Fitro Praaidinza Muhammad\n21.0504.0025',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            _launchURL('https://pddikti.kemdikbud.go.id/data_mahasiswa/RjE2QUVFNjYtNjI3Ri00OTI1LTlEMTAtNDVGRDcwNUVDNkYz');
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Ulil Albab\n21.0504.0037',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 52),
                        Center(
                          child: Text(
                            'Universitas Muhammadiyah',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Magelang',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InfoPage(),
  ));
}
