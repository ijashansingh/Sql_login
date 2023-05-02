import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Database_class{

  static Database? _db ;

  Future<Database?> get db async{

    if(_db==null){
      _db = await initializedDB();
      return _db;
    }
    return _db;

  }

  Future<Database> initializedDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'data.db');
    Database mydb = await openDatabase(path ,onCreate: _create,version: 4);

    return mydb ;
  }

   _create(Database db,int version) async {

    await db.execute('''
    CREATE TABLE 'notes'(
    'note' TEXT NOT NULL,
    'password' TEXT NOT NULL)
    
    ''');

    print("database is created ========");
  }

  readdata(String sql) async{
    Database? mydb = await db ;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertdata(String sql) async{
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  check_data(String msgid) async{
    Database? mydb = await db ;
    String queryCheck = "SELECT * from notes WHERE note = '" + msgid + "'";
    var response = await mydb!.rawQuery(queryCheck);
    return response;
  }

  check_data2(String username,String password) async{
    Database? mydb = await db ;
    String queryCheck = "SELECT * from notes WHERE note = '" + username + "'AND password = '" + password + "'";
    var response = await mydb!.rawQuery(queryCheck);
    return response;
  }


}


