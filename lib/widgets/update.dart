import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:creative_app/screens/myhome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../sqflite.dart';

class UpdateScreen extends StatefulWidget {
  late final String title;
  late final String time;
  late final String date;
  late final String type;
  late final int id;

  UpdateScreen(
      {required this.title,
      required this.date,
      required this.type,
      required this.time,
      required this.id});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  //SqfLiteApp sqfLiteApp = SqfLiteApp();
  TextEditingController textController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.title;
    timeController.text = widget.time;
    dateController.text = widget.date;
    typeController.text = widget.type;
    super.initState();
  }

  int selectedIndex = 0;

  void setSelectedIndex(int selectedIndex) {
    this.selectedIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdateDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: Container(
            // padding:
//         EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[300],
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  left: 0,
                  top: MediaQuery.of(context).size.height / 8,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(175, 25),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 340,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Image.asset(
                              'assets/images/fab-delete.png',
                            ),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [boxShadow(MyColors.purpleShadow)],
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  MyColors.purpleLight,
                                  MyColors.purpleDark,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Add new task',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                controller: textController,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width / 1.2,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.5,
                                    color: MyColors.textGrey,
                                  ),
                                ),
                              ),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  cubit.myOptions[index]
                                      .setSelectedIndex(selectedIndex);
                                  return InkWell(
                                    child: cubit.myOptions[index].myInkWell(),
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        cubit.myOptions[index]
                                            .setSelectedIndex(selectedIndex);
                                      });
                                    },
                                  );
                                },
                                itemCount: cubit.myOptions.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Text(
                                'Choose date',
                                style: TextStyle(
                                    color: MyColors.textSubHeaderGrey,
                                    fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Row(
                                children: [
                                  Text(
                                    '${cubit.strDate}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: cubit.pickedDate,
                                        firstDate: cubit.pickedDate,
                                        lastDate: DateTime.parse('2023-01-01'),
                                        currentDate: cubit.pickedDate,
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                        cubit.updateDate(value);
                                      });
                                    },
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Text(
                                'Choose time',
                                style: TextStyle(
                                    color: MyColors.textSubHeaderGrey,
                                    fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Row(
                                children: [
                                  Text(
                                    '${cubit.strTime}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: cubit.pickedTime,
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context);
                                        cubit.updateTime(value);
                                      });
                                    },
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                String? intType = cubit.colorTypes[
                                    cubit.myOptions[selectedIndex].myColor];
                                await cubit.updateDatabase(
                                  title: textController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  type: intType!,
                                  id: widget.id,
                                  status: cubit.data[selectedIndex]['status'],
                                  // context: context
                                );
                              },
                              textColor: Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 50,
                                width: 240,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      colors: [
                                        MyColors.blueDark,
                                        MyColors.blueLight,
                                      ],
                                    ),
                                    boxShadow: [
                                      boxShadow(MyColors.greyBorder),
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Update Task',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
