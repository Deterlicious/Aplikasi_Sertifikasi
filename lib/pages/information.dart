import 'package:flutter/material.dart';

class InforPages extends StatelessWidget {
  const InforPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        backgroundColor: const Color(0xff1b263b),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Aplikasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0077b6),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Aplikasi "siMahasiswa" dirancang untuk menyederhanakan pengelolaan data mahasiswa. Dengan antarmuka yang user-friendly, pengguna dapat dengan cepat menambah, melihat, memperbarui, dan menghapus informasi mahasiswa seperti NIM, nama, email, dan alamat.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Fitur Popup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0077b6),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Fitur popup yang praktis memungkinkan pengeditan dan penghapusan data dengan mudah melalui opsi tekan dan tahan.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Solusi Efisien',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0077b6),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Solusi ini cocok untuk lembaga pendidikan yang ingin mengelola informasi mahasiswa secara efisien.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
