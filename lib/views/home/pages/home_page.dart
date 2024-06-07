import 'package:flutter/material.dart';
import '../../../services/auth/auth_service.dart';
import '../components/custom_drawer.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,


      ),
      drawer: const CustomDrawer(),
      body: Scaffold(),
    );
  }

}
