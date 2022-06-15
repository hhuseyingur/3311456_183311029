import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi {
  late Database db;

  static Future<String> databaseYol({required String dosyaadi}) async {
    Future<dynamic> _getDirectory() async {
      Directory directory;
      String newPath = (await getDatabasesPath());
      directory = Directory(newPath);
      return directory;
    }

    Future<String> createFolderInAppDocDir() async {
      //Get this App Document Directory
      final Directory _appDocDir = await _getDirectory();
      //App Document Directory + folder name
      final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/kullanicilar-db/');

      if (await _appDocDirFolder.exists()) {
        //if folder already exists return path
        return _appDocDirFolder.path;
      } else {
        //if folder not exists create folder and then return its path
        final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
        return _appDocDirNewFolder.path;
      }
    }

    final String databaseAddFolderPath = await createFolderInAppDocDir();

    return join(databaseAddFolderPath, dosyaadi);
  }


  static Future<Database> veritabaniErisim() async {
    String veritabaniAdi = "bunudaoku.db";
    String colid = "id";
    String colname = "name";
    String collastname = "lastName";
    String colemail = "email";
    String colpassword = "password";
    String colimgpath = "imgPath";

    String tbluser = 'user';

    Future<dynamic> _getDirectory() async {
      Directory directory;
      String newPath = (await getDatabasesPath());
      directory = Directory(newPath);
      return directory;
    }

    Future<String> createFolderInAppDocDir() async {
      //Get this App Document Directory
      final Directory _appDocDir = await _getDirectory();
      //App Document Directory + folder name
      final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/kullanicilar-db/');

      if (await _appDocDirFolder.exists()) {
        //if folder already exists return path
        return _appDocDirFolder.path;
      } else {
        //if folder not exists create folder and then return its path
        final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
        return _appDocDirNewFolder.path;
      }
    }

    final String databaseAddFolderPath = await createFolderInAppDocDir();

    String veritabaniYolu = join(databaseAddFolderPath, veritabaniAdi);

    void _createDb(Database db, int newVersion) async {
      await db.execute(
          "CREATE TABLE $tbluser($colid INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT, $collastname TEXT, $colemail TEXT, $colpassword TEXT, $colimgpath TEXT)");
    }

    //Veritabanını açıyoruz.
    return openDatabase(veritabaniYolu, version: 1, onCreate: _createDb);
  }

  Future close() async {
    db.close();
  }
}
