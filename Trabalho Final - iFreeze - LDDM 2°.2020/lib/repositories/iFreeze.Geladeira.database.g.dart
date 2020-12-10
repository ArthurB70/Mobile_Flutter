// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iFreeze.Geladeira.database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GeladeiraDao _geladeiraDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Geladeira` (`codigoGeladeira` INTEGER PRIMARY KEY AUTOINCREMENT, `nome` TEXT, `status` INTEGER, `topico` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GeladeiraDao get geladeiraDao {
    return _geladeiraDaoInstance ??= _$GeladeiraDao(database, changeListener);
  }
}

class _$GeladeiraDao extends GeladeiraDao {
  _$GeladeiraDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _geladeiraInsertionAdapter = InsertionAdapter(
            database,
            'Geladeira',
            (Geladeira item) => <String, dynamic>{
                  'codigoGeladeira': item.codigoGeladeira,
                  'nome': item.nome,
                  'status': item.status == null ? null : (item.status ? 1 : 0),
                  'topico': item.topico
                }),
        _geladeiraUpdateAdapter = UpdateAdapter(
            database,
            'Geladeira',
            ['codigoGeladeira'],
            (Geladeira item) => <String, dynamic>{
                  'codigoGeladeira': item.codigoGeladeira,
                  'nome': item.nome,
                  'status': item.status == null ? null : (item.status ? 1 : 0),
                  'topico': item.topico
                }),
        _geladeiraDeletionAdapter = DeletionAdapter(
            database,
            'Geladeira',
            ['codigoGeladeira'],
            (Geladeira item) => <String, dynamic>{
                  'codigoGeladeira': item.codigoGeladeira,
                  'nome': item.nome,
                  'status': item.status == null ? null : (item.status ? 1 : 0),
                  'topico': item.topico
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Geladeira> _geladeiraInsertionAdapter;

  final UpdateAdapter<Geladeira> _geladeiraUpdateAdapter;

  final DeletionAdapter<Geladeira> _geladeiraDeletionAdapter;

  @override
  Future<List<Geladeira>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Geladeira order by nome',
        mapper: (Map<String, dynamic> row) => Geladeira(
            codigoGeladeira: row['codigoGeladeira'] as int,
            nome: row['nome'] as String,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            topico: row['topico'] as String));
  }

  @override
  Future<Geladeira> getGeladeiraBycodigoGeladeira(int codigoGeladeira) async {
    return _queryAdapter.query(
        'SELECT * from Geladeira where codigoGeladeira = ?',
        arguments: <dynamic>[codigoGeladeira],
        mapper: (Map<String, dynamic> row) => Geladeira(
            codigoGeladeira: row['codigoGeladeira'] as int,
            nome: row['nome'] as String,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            topico: row['topico'] as String));
  }

  @override
  Future<int> insertGeladeira(Geladeira p) {
    return _geladeiraInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateGeladeira(Geladeira p) {
    return _geladeiraUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteGeladeira(Geladeira p) {
    return _geladeiraDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
