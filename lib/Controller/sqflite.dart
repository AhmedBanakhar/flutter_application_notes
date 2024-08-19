import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqfLite{

  Database? _db;
  Future<Database?> get db async{
  if(_db==null){
    _db = await intialDb();
    return _db;
  }else{
    return _db;
  }
  }

  intialDb () async{

    String DataBasePath=await getDatabasesPath();

    String path = join(DataBasePath,'ahmed.db');
    Database Mydb = await openDatabase(path,version: 1,onCreate: _onCreate,onUpgrade:_onUpgrad);
    return Mydb;
  }
   _onUpgrad(Database db,int oldversion,int newversion)async{
  print('_onUpgrad');
  //await db .execute('ALTER TABLE notes ADD COLUMN Color TEXT');When i need to update or add new column tp the table 
  }
  //this functino use to cearte new table
   _onCreate(Database db,int version) async{
    await db.execute('''
    CREATE TABLE "notes" (
     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
     "Title" TEXT,
     "Note" TEXT
    
    )
     ''');
    print("onCreate");
  }

  ReadData(String sql) async{
    Database? Mydb =await db;
    List<Map> result = await Mydb!.rawQuery(sql);
    return result;
  }
  insertData(String sql)async{
    Database? Mydb =await db;
    int result= await Mydb!.rawInsert(sql);
    return result;
  }
  updataDate(String sql)async{
    Database? Mydb =await db;
    int result= await Mydb!.rawUpdate(sql);
    return result;
  }
  deleteData(String sql)async{
    Database? Mydb =await db;
    int result=await Mydb!.rawDelete(sql);
    return result;
  }
  //the secand way
// _OnCreate(Database db,int version)async{
//   Batch batch=db.batch();
//   batch.execute('''
//     'CREATE TABLE notes (
//      "id" INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,
//      "Title" TEXT,
//      "Note" TEXT
    
//     )
// ''');
//     await batch.commit();
// }
  readData(String table)async{
    Database? Mydb =await db;
    List<Map> result = await Mydb!.query(table);
    return result;
  }
  InsertData(String table,Map<String, Object?> values)async{
    Database? Mydb= await db;
    int result= await Mydb!.insert(table,values);
    return result;
  }
  UpdataData(String table,Map<String, Object?> values,String? Mywhere)async{
    Database? Mydb= await db;
    int result=await Mydb!.update(table, values,where: Mywhere);
    return result;
  }
  DeleteData(String table,String? Mywhere)async{
    Database? Mydb= await db;
    int result=await Mydb!.delete(table,where: Mywhere);
    return result;
  }

//this function foe delete the database 
myDeleteData()async{
  String DataBasePath=await getDatabasesPath();
  String path=join(DataBasePath,'ahmed.db');
  await deleteDatabase(path);
  
}



}