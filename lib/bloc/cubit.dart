import 'package:bloc/bloc.dart';
import 'package:creative_app/bloc/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // late int currentIndex = 0;
  late Database database;
  List data = [];
  bool isLoading = true;
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  String strTime = DateFormat.jm().format(DateTime.now());
  String strDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  // List<Map> newtasks = [];
  // List<Map> donetasks = [];
  // List<Map> archivetasks = [];
  //
  // List<Widget> models = [
  //   Tasks(),
  //   done(),
  //   Archived(),
  // ];

  void createDatabase() {
    openDatabase(
      'dataAAb.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT , date TEXT , time TEXT ,status TEXT,type TEXT )')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Table is error ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          data = value;
          print(value);
          emit(AppGetDatabaseState());
        });
        print('Opened database');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
    required String type,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status,type) VALUES("$title" ,"$date","$time","new","$type")')
          .then((value) {
        emit(AppInsertDatabaseState());
        print('$value data inserted successful');

        getDataFromDatabase(database).then((value) {
          data = value;
          print(value);
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('data inserted error is ${error.toString()}');
      });
    });
  }

  Future<List> getDataFromDatabase(database) async {
    // newtasks = [];
    // donetasks = [];
    // archivetasks = [];
    return await database.rawQuery('SELECT * FROM tasks');
    //     value.forEach((element) {
    //       if (element['status'] == 'new')
    //         newtasks.add(element);
    //       else if (element['status'] == 'done')
    //         donetasks.add(element);
    //       else
    //         archivetasks.add(element);
    //     });
    //   });
    // }
  }

  Future updateDatabase({
    required String status,
    required String date,
    required String title,
    required String time,
    required int id,
  }) async {
    await database.rawUpdate('''UPDATE tasks SET title= "$title",
            date="${date}",
            time="${time}",
            state="${state}" WHERE id=${id}''').then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteDatabase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void updateDate(DateTime date) {
    pickedDate = date;
    strDate = DateFormat("yyyy-MM-dd").format(pickedDate);
    strTime = DateFormat.jm().format(DateTime(pickedDate.year, pickedDate.month,
        pickedDate.day, pickedTime.hour, pickedTime.minute));
    emit(AppUpdatePickedDate());
  }

  void updateTime(TimeOfDay time) {
    pickedTime = time;
    strDate = DateFormat("yyyy-MM-dd").format(pickedDate);
    strTime = DateFormat.jm().format(DateTime(pickedDate.year, pickedDate.month,
        pickedDate.day, pickedTime.hour, pickedTime.minute));
    emit(AppUpdatePickedTime());
  }
}
