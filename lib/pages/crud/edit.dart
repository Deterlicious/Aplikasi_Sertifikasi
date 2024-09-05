import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPages extends StatefulWidget {
  final String nim;
  final String nama;
  final String alamat;
  final String email;
  final String id;

  const EditPages({
    super.key,
    required this.nim,
    required this.nama,
    required this.alamat,
    required this.email,
    required this.id,
  });

  @override
  State<EditPages> createState() => _EditPagesState();
}

class _EditPagesState extends State<EditPages> {
  late TextEditingController controllerNim;
  late TextEditingController controllerNama;
  late TextEditingController controllerEmail;
  late TextEditingController controllerAlamat;
  late TextEditingController controllerId;



  @override
  void initState() {
    super.initState();
    controllerNim = TextEditingController(text: widget.nim);
    controllerNama = TextEditingController(text: widget.nama);
    controllerEmail = TextEditingController(text: widget.email);
    controllerAlamat = TextEditingController(text: widget.alamat);
    controllerId = TextEditingController(text: widget.id);

  }

  @override
  void dispose() {
    controllerNim.dispose();
    controllerNama.dispose();
    controllerEmail.dispose();
    controllerAlamat.dispose();
    controllerId.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    var nim = controllerNim.text;
    var nama = controllerNama.text;
    var email = controllerEmail.text;
    var alamat = controllerAlamat.text;
    var id = controllerId.text;

    try {
      final String url =
          "https://api-sertifikasi.vercel.app/api/api/mahasiswa/$id"; // Sesuaikan URL untuk update
      final response = await http.put(Uri.parse(url), body: {
        "nim": nim,
        "nama": nama,
        "email": email,
        "alamat": alamat,
      });

      if (response.statusCode == 200) {
        // Berhasil mengedit, kembali ke halaman sebelumnya
        Navigator.pop(context, true);
      } else {
        // Handle error
        print('Failed to update data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: controllerNim,
              decoration: const InputDecoration(
                labelText: 'Nim',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerNama,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerAlamat,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () => handleSubmit(),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
