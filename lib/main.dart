import 'package:flutter/material.dart';
import 'package:quraanrevision/views/pages/splash/splash.dart';

import 'database/copyfrom DB.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuraanDB.initialDB();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    )
  );
}


