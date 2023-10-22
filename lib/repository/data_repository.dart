import 'package:dio_imc_data_flutter/model/imc_today.dart';
import 'package:dio_imc_data_flutter/model/pessoa.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

class DataRepository {
  final Database _db;
  DataRepository(this._db);

  Future<Pessoa?> getPessoa() async {
    // var data = await _db.rawQuery('SELECT id, nome, altura, peso FROM user');
    List<Map<String, dynamic>> data = await _db.query('user', limit: 1);
    debugPrint(data.toString());

    if (data.isEmpty) return null;
    // TODO
    Pessoa pessoa = Pessoa.fromMap(data.first);
    return pessoa;
  }

  Future<List<Pessoa>> getPessoas() async {
    List<Pessoa> list = [];
    var data = await _db.query('user');
    // var data = await _db.rawQuery('SELECT id, nome, altura, peso FROM user');
    debugPrint(data.toString());

    for (var p in data) {
      // TODO
      Pessoa pessoa = Pessoa.fromMap(p);
      list.add(pessoa);
    }

    return list;
  }

  Future<void> salvarPessoa(Pessoa pessoa) async {
    // await _db.insert(
    //   'user',
    //   pessoa.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );

    await _db.rawInsert(
      'INSERT INTO user (nome, altura, peso) values(?,?,?)',
      [
        pessoa.nome,
        pessoa.altura.round(),
        pessoa.peso.round(),
      ],
    );
  }

  Future<void> deletePessoa(int id) async {
    await _db.delete('user', where: 'id = ?', whereArgs: [id]);
    // await _db.rawInsert('DELETE  user  WHERE id = ?', [id]);
  }

  Future<void> updatePessoa(Pessoa pessoa) async {
    await _db.update(
      'user',
      pessoa.toMap(),
      where: 'id = ?',
      whereArgs: [pessoa.id],
    );

    // await _db.rawInsert(
    //     'UPDATE  user SET nome = ?, altura = ?, peso = ? WHERE id = ?',
    //     [pessoa.nome, pessoa.altura, pessoa.peso, pessoa.id]);
  }

  /////////////////////
  ///

  Future<ImcToday?> getImcToday(int id) async {
    List<Map<String, dynamic>> data = await _db.query('imc_today',
        where: 'id = ?', whereArgs: [id], limit: 1);
    debugPrint(data.toString());
    if (data.isEmpty) return null;
    // TODO
    ImcToday imcToday = ImcToday.fromMap(data.first);
    return imcToday;
  }

  Future<List<ImcToday>> getImcTodayList() async {
    List<ImcToday> list = [];
    var data = await _db.query('imc_today');

    debugPrint(data.toString());

    for (var imc in data) {
      // TODO
      ImcToday imcToday = ImcToday.fromMap(imc);
      list.add(imcToday);
    }

    return list;
  }

  Future<void> salvarImcToday(ImcToday imcToday) async {
    // await _db.insert(
    //   'imc_today',
    //   imcToday.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );

    await _db.rawInsert(
      'INSERT INTO imc_today (dateTime,  imc) values(?,?)',
      [
        imcToday.dateTime.millisecondsSinceEpoch,
        imcToday.imc.round(),
      ],
    );
  }

  Future<void> deleteImcToday(int id) async {
    await _db.delete('imc_today', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateImcToday(ImcToday imcToday) async {
    await _db.update(
      'imc_today',
      imcToday.toMap(),
      where: 'id = ?',
      whereArgs: [imcToday.id],
    );
  }
}
