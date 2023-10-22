import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  static const _tableName1 = 'user';
  static const _tableName2 = 'imc_today';

  static final List<DatabaseVersion> _databaseVersions = [
    DatabaseVersion(1, [
      '''
      CREATE TABLE $_tableName1 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        peso REAL,
        altura REAL
      );
    ''',
      '''
      CREATE TABLE $_tableName2 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dateTime INT,
        imc REAL
      );
    '''
    ]),
    // Adicione mais versões e scripts aqui conforme necessário
  ];

  get database async {
    if (_database != null) return _database;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        'users.db',
      ),
      version: _databaseVersions.length,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  _onCreate(Database db, int version) async {
    for (var data in _databaseVersions) {
      for (var script in data.scriptList) {
        await db.execute(script);
      }
    }
  }

  _onUpgrade(Database db, int oldVersion, int version) async {
    for (var i = oldVersion + 1; i <= version; i++) {
      final data = _databaseVersions[i];
      for (var script in data.scriptList) {
        await db.execute(script);
      }
    }
  }
}

class DatabaseVersion {
  final int version;
  final List<String> scriptList;

  DatabaseVersion(this.version, this.scriptList);
}
