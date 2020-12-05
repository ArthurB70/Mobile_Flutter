import 'package:floor/floor.dart';
import 'dart:async';
import 'package:iFreeze/models/iFreeze.Comida.model.dart';
import 'iFreeze.ComidaDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'iFreeze.Comida.database.g.dart'; 

@Database(version: 1,entities: [Comida])
abstract class AppDatabase extends FloorDatabase{
ComidaDao get comidaDao;
}
