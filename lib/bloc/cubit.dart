import 'package:bloc/bloc.dart';
import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/constants/colors.dart';

import 'package:creative_app/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List myOptions = [
    inkWell(
      MyColors.yellowAccent,
      'Personal',
      MyColors.yellowIcon,
      0,
    ),
    inkWell(
      MyColors.greenIcon,
      'Work',
      MyColors.greenIcon,
      1,
    ),
    inkWell(
      MyColors.purpleIcon,
      'Meeting',
      MyColors.purpleIcon,
      2,
    ),
    inkWell(
      MyColors.blueIcon,
      'Study',
      MyColors.blueIcon,
      3,
    ),
    inkWell(
      MyColors.orangeIcon,
      'Shopping',
      MyColors.orangeIcon,
      4,
    ),
    inkWell(
      MyColors.deepPurpleIcon,
      'Free Time',
      MyColors.deepPurpleIcon,
      5,
    ),
  ];
  Map<Color, String> colorTypes = {
    MyColors.yellowIcon: 'Personal',
    MyColors.greenIcon: 'Work',
    MyColors.purpleIcon: 'Meeting',
    MyColors.blueIcon: 'Study',
    MyColors.orangeIcon: 'Shopping',
    MyColors.deepPurpleIcon: 'Free Time',
  };

  late Database database;
  List data = [];
  List myTasks = [];
  List taskIcons = [];
  int personalCount = 0;
  int workCount = 0;
  int meetingCount = 0;
  int studyCount = 0;
  int shoppingCount = 0;
  int freeTimeCount = 0;
  bool isLoading = false;
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  String strTime = DateFormat.jm().format(DateTime.now());
  String strDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  IconData taskNotDone = Icons.radio_button_unchecked;
  IconData taskDone = Icons.check_circle;
  IconData checkTask = Icons.radio_button_unchecked;

  void createDatabase() {
    isLoading = true;
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
      onOpen: (database) async {
        print('Opening Database ---------------------------');
        await getDataFromDatabase(database).then((value) {
          print('tasks: ${value}');
        });
      },
    ).then((value) {
      print('Opened database');
      database = value;
      // getDataFromDatabase(database).then((value) {
      //   print(value);
      // });
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
      await txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status,type) VALUES("$title" ,"$date","$time","new","$type")')
          .then((value) {
        emit(AppInsertDatabaseState());
        print('$value data inserted successful');
        getDataFromDatabase(database).then((value) {
          print(value);
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
    isLoading = false;
    personalCount = workCount =
        meetingCount = studyCount = shoppingCount = freeTimeCount = 0;
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      data = value;
      for (var element in data) {
        if (element['type'] == 'Personal')
          personalCount++;
        else if (element['type'] == 'Work')
          workCount++;
        else if (element['type'] == 'Meeting')
          meetingCount++;
        else if (element['type'] == 'Study')
          studyCount++;
        else if (element['type'] == 'Shopping')
          shoppingCount++;
        else
          freeTimeCount++;
      }
    });
    taskIcons.clear();
    for (var task in data) {
      taskIcons.add(
        Icon(
          task['status'] == "new" ? taskNotDone : taskDone,
          color: colorTypes.keys.firstWhere(
              (k) => colorTypes[k] == task['type'],
              orElse: () => Colors.red),
          size: 24,
        ),
      );
    }
    emit(AppGetDatabaseState());
    return data;
  }

  void pickedTypeTasks(String type) {
    myTasks.clear();
    for (var element in data) {
      if (element['type'] == type) myTasks.add(element);
    }
    emit(AppSelectTypeState());
  }

  Future updateDatabase({
    required String type,
    required String date,
    required String title,
    required String time,
    required String status,
    required int id,
    // required BuildContext context,
  }) async {
    await database.rawUpdate('''UPDATE tasks SET title="$title",
            date="${date}",
            time="${time}",
            status="${status}",
            type="${type}"
            WHERE id=${id}''').then((value) {
      getDataFromDatabase(database).then((value) {
        print(value);
      });
    }).catchError((error) {
      print('data update error is ${error.toString()}');
    });
    emit(AppUpdateDatabaseState());
    // Navigator.pop(context);
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

//TODO:REMOVE
//TODO:CLOSE APPBAR

  void toggleDone(int index) {
    var myTask = data[index];
    var status = myTask['status'] == "new" ? "done" : "new";
    updateDatabase(
        type: myTask['type'],
        date: myTask['date'],
        title: myTask['title'],
        time: myTask['time'],
        status: status,
        id: myTask['id']);
    emit(AppTaskDone());
  }

  // Future<bool> isFreshInstalled({required bool seen}) async {
  //   const String key = "success moving";
  //   var pref = await SharedPreferences.getInstance();
  //   bool? seen = pref.getBool(key);
  //   if (seen == null) {
  //     return await pref.setBool(key, false);
  //   } else {
  //     return seen;
  //   }
  // }
}
