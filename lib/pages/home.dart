import 'package:flutter/material.dart';
import 'package:praktek/pages/crud/create.dart';
import 'package:praktek/pages/crud/lihat_data.dart';
import 'package:praktek/pages/information.dart';
import 'package:praktek/pages/login.dart';

class HomeScreen extends StatelessWidget {
  final String user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: ListView(
          children: [
            _header(),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildAnimatedCard(
                    context,
                    "Lihat Data",
                    Icons.person_pin_rounded,
                    const ListData(),
                  ),
                  buildAnimatedCard(
                    context,
                    "Buat Data",
                    Icons.add_chart,
                    const CreateData(),
                  ),
                  buildAnimatedCard(
                    context,
                    "Tentang Kami",
                    Icons.info_outline,
                    const InforPages(),
                  ),
                  buildAnimatedCard(
                    context,
                    "Log Out",
                    Icons.logout,
                    const LoginPages(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xffd7d7d7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(icon, size: 30),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Container _header() {
    return Container(
      height: 340,
      decoration: const BoxDecoration(
        color: Color(0xff094067),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Welcome, $user",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset("assets/dashboard.png"),
        ],
      ),
    );
  }
}
