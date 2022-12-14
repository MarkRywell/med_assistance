import 'package:flutter/material.dart';
import 'package:med_assistance/views/home_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal
        ),
        home: const HomePage()
      ));
}


