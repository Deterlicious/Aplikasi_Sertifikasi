import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  TextEditingController controllerNim = TextEditingController(text: "");
  TextEditingController controllerNama = TextEditingController(text: "");
  TextEditingController controllerEmail = TextEditingController(text: "");
  TextEditingController controllerAlamat = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    handleSubmit() async {
      var nim = controllerNim.text;
      var nama = controllerNama.text;
      var email = controllerEmail.text;
      var alamat = controllerAlamat.text;

      try {
        const String url =
            "https://api-sertifikasi.vercel.app/api/api/mahasiswa";
        final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "nim": nim,
            "nama": nama,
            "email": email,
            "alamat": alamat,
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            controllerNim.clear();
            controllerNama.clear();
            controllerEmail.clear();
            controllerAlamat.clear();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data gagal disimpan!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil disimpan!')),
          );
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data'),
        backgroundColor: const Color(0xff094067),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(controllerNim, 'Nim'),
            const SizedBox(height: 20),
            _buildTextField(controllerNama, 'Nama'),
            const SizedBox(height: 20),
            _buildTextField(controllerEmail, 'Email'),
            const SizedBox(height: 20),
            _buildTextField(controllerAlamat, 'Alamat'),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xff3d5a80), Color(0xff98c1d9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueGrey),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff3d5a80)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xff3d5a80)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xff98c1d9)),
        ),
      ),
    );
  }
}
