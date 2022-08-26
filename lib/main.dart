

import 'package:card_hive/pages/detail_page.dart';
import 'package:card_hive/pages/home_page.dart';
import 'package:card_hive/service/db_service.dart';
import 'package:flutter/material.dart';

void main () async {
  await DBService.init;
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
