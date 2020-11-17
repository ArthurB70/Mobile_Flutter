import 'dart:async';

import 'package:floor/floor.dart';
import '../models/Aluno.model.dart';
import '../repositories/Aluno.dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'Aluno.database.g.dart'; 

@Database(version: 1,entities: [Aluno])
abstract class AppDatabase extends FloorDatabase{
  AlunoDao get alunoDao;
}