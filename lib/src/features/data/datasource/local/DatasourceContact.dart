import 'package:agendateste/src/core/datasource/IDatasourceContact.dart';
import 'package:agendateste/src/core/domain/entity/ContactEntity.dart';
import 'package:agendateste/src/features/data/models/ContactModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DatasourceContact extends IDatasourceContact {
   Database? _db;
  static const String _NAME = 'name';
  static const String _ID = 'id';

  static const String _PHONECEL = 'phoneCel';

  static const String _PHOTOIMG = "photoImg";
  static const String _TABLE = "CONTACTS";
  static const String _DB_NAME= "contactdb.db";

  
  @override
  Future<ContactEntity> create(Map<String, dynamic> data) async{
    data.remove('id');
    var dbClient = await _getDb;
    final  result = await dbClient?.insert(_TABLE, data);
    
    return ContactModel.fromMap(data..['id'] = result?.toString());
  }

  @override
  Future<bool> delete(Map<String, dynamic> data) async{
    var dbClient = await _getDb;
    await dbClient?.delete(_TABLE,where: '$_ID = ?',whereArgs: [data[_ID]]);

    return true;
  }

  @override
  Future<List<ContactEntity>> read() async{
    var dbClient = await _getDb;
    List<Map<String,dynamic>> maps = await dbClient!.query(_TABLE,columns: [_ID,_NAME,_PHONECEL,_PHOTOIMG]);
    List<ContactEntity> contacts = [];
    for( var i = 0 ; i < maps.length ; i++){
      contacts.add(ContactModel.fromMap(maps[i]));
    }
    return contacts;
  }

  @override
  Future<bool> update(Map<String, dynamic> data) async{
    var dbClient = await _getDb;
    await dbClient?.update(_TABLE, data,where: '$_ID = ?',whereArgs:[data[_ID]]);

    return true;
  }


  _init()async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _DB_NAME);
    _db = await openDatabase(path,version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version)async{
    print('banco criado ');
    await db.execute(
      'CREATE TABLE $_TABLE ($_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$_NAME TEXT, $_PHONECEL TEXT, TEXT,$_PHOTOIMG)');
  }
  Future<Database?> get _getDb async{
    if(_db != null){
      return _db;
    }
    await _init();
    return _db;
  }


}