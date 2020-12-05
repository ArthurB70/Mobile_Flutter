// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iFreeze.Comida.database.dart';

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

  ComidaDao _comidaDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Comida` (`codigoGeladeira` INTEGER, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `nome` TEXT, `quantidade` INTEGER, `validade` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ComidaDao get comidaDao {
    return _comidaDaoInstance ??= _$ComidaDao(database, changeListener);
  }
}

class _$ComidaDao extends ComidaDao {
  _$ComidaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _comidaInsertionAdapter = InsertionAdapter(
            database,
            'Comida',
            (Comida item) => <String, dynamic>{
                  'codigoGeladeira': item.codigoGeladeira,
                  'id': item.id,
                  'nome': item.nome,
                  'quantidade': item.quantidade,
                  'validade': item.validade
                }),
        _comidaUpdateAdapter = UpdateAdapter(
            database,
            'Comida',
            ['id'],
            (Comida item) => <String, dynamic>{
                  'codigoGeladeira': item.codigoGeladeira,
                  'id': item.id,
                  'nome': item.nome,
                  'quantidade': item.quantidade,
                  'validade': item.validade
                }),
        _comidaDeletionAdapter = DeletionAdapter(
            database,
            'Comida',
            ['id'],
            (Comida item) => <String, dynamic>{
                  'codigoGeladeira': item.codigoGeladeira,
                  'id': item.id,
                  'nome': item.nome,
                  'quantidade': item.quantidade,
                  'validade': item.validade
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Comida> _comidaInsertionAdapter;

  final UpdateAdapter<Comida> _comidaUpdateAdapter;

  final DeletionAdapter<Comida> _comidaDeletionAdapter;

  @override
  Future<List<Comida>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Comida order by nome',
        mapper: (Map<String, dynamic> row) => Comida(
            codigoGeladeira: row['codigoGeladeira'] as int,
            id: row['id'] as int,
            nome: row['nome'] as String,
            quantidade: row['quantidade'] as int,
            validade: row['validade'] as String));
  }

  @override
  Future<List<Comida>> getComidaBycodigoGeladeira(int codigoGeladeira) async {
    return _queryAdapter.queryList(
        'SELECT * from Comida where codigoGeladeira = ?',
        arguments: <dynamic>[codigoGeladeira],
        mapper: (Map<String, dynamic> row) => Comida(
            codigoGeladeira: row['codigoGeladeira'] as int,
            id: row['id'] as int,
            nome: row['nome'] as String,
            quantidade: row['quantidade'] as int,
            validade: row['validade'] as String));
  }

  @override
  Future<Comida> getComidaByqrCode(int id) async {
    return _queryAdapter.query('SELECT * from Comida where id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Comida(
            codigoGeladeira: row['codigoGeladeira'] as int,
            id: row['id'] as int,
            nome: row['nome'] as String,
            quantidade: row['quantidade'] as int,
            validade: row['validade'] as String));
  }

  @override
  Future<int> insertComida(Comida p) {
    return _comidaInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateComida(Comida p) {
    return _comidaUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteComida(Comida p) {
    return _comidaDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
