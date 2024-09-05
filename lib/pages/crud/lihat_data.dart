import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:praktek/pages/crud/DetailData.dart';
import 'package:praktek/pages/crud/edit.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  bool isLoading = false;
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const String url = "https://api-sertifikasi.vercel.app/api/api/mahasiswa";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          isLoading = true;
          data = jsonDecode(response.body)['data'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  deleteData(id) async {
    final String url =
        "https://api-sertifikasi.vercel.app/api/api/mahasiswa/$id";
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data gagal dihapus!')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Data',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff094067),
      ),
      body: isLoading
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                            onTap: () {
                              Navigator.pop(context); // Tutup popup

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPages(
                                    id: data[index]['id'].toString(),
                                    nama: data[index]['nama'],
                                    alamat: data[index]['alamat'],
                                    nim: data[index]['nim'].toString(),
                                    email: data[index]['email'],
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Hapus'),
                            onTap: () {
                              Navigator.pop(context); // Tutup popup
                              deleteData(data[index]['id']); // Hapus data
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailData(
                                  nama: data[index]['nama'],
                                  alamat: data[index]['alamat'],
                                  nim: data[index]['nim'].toString(),
                                  email: data[index]['email'],
                                )))
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blueGrey,
                        )),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data[index]['nama'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        const Icon(Icons.chevron_right_outlined)
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
