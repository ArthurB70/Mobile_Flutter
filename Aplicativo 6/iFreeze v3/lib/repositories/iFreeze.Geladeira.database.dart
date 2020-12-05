import 'package:floor/floor.dart';
import 'dart:async';
import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';
import 'iFreeze.GeladeiraDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'iFreeze.Geladeira.database.g.dart'; 

@Database(version: 1,entities: [Geladeira])
abstract class AppDatabase extends FloorDatabase{
GeladeiraDao get geladeiraDao;
}
