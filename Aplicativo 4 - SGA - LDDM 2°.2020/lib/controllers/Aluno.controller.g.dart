// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Aluno.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlunoController on _AlunoController, Store {
  final _$listAtom = Atom(name: '_AlunoController.list');

  @override
  ObservableList<Aluno> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<Aluno> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('_AlunoController.getAll');

  @override
  Future<void> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$createAsyncAction = AsyncAction('_AlunoController.create');

  @override
  Future<void> create(Aluno p) {
    return _$createAsyncAction.run(() => super.create(p));
  }

  final _$updateAsyncAction = AsyncAction('_AlunoController.update');

  @override
  Future<void> update(Aluno p) {
    return _$updateAsyncAction.run(() => super.update(p));
  }

  final _$deleteAsyncAction = AsyncAction('_AlunoController.delete');

  @override
  Future<void> delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
