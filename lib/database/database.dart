import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class AssetDatabase {
  static Future<Database> prepareDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "cities_list.db");

    Database db;
    // try opening (will work if it exists)
    try {
      db = (await openDatabase(path, readOnly: true));
    } catch (e) {
      print("Error $e");
    }

    if (db == null) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "cities.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
      
      return await openDatabase(path, readOnly: true);
    } else {
      print("Opening existing database");
      return db;
    }
  }
}
