import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:creative_app/screens/myhome_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Add_Task_Screen extends StatefulWidget {
  const Add_Task_Screen({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  State<Add_Task_Screen> createState() => _Add_Task_ScreenState();
}

class _Add_Task_ScreenState extends State<Add_Task_Screen> {
  TextEditingController textController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  //SqfLiteApp sqfLiteApp = SqfLiteApp();

  int selectedIndex = 0;
  void setSelectedIndex(int selectedIndex) {
    this.selectedIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Container(
          // padding:
//         EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: MediaQuery.of(context).size.height,
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
                                labelText: 'Enter something',
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
                              // int response = await cubit.insertToDatabase(
                              await cubit.insertToDatabase(
                                  title: textController.text,
                                  time: timeController.text,
                                  date: dateController.text,
                                  type: intType!);
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
                                  'Add task',
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
        );
      },
    );
  }
}

class inkWell {
  final Color color;
  final String text;
  final Color myColor;
  final int myIndex;
  int selectedIndex = -1;

  inkWell(this.color, this.text, this.myColor, this.myIndex);

  void setSelectedIndex(int selectedIndex) {
    this.selectedIndex = selectedIndex;
  }

  Widget myInkWell() {
    BoxDecoration displayedDecoration = BoxDecoration();
    if (this.selectedIndex == this.myIndex) {
      displayedDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [boxShadow(myColor)],
      );
    } else {
      displayedDecoration = BoxDecoration();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: displayedDecoration,
        child: Center(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(right: 4),
                height: 10,
                width: 10,
              ),
              Container(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
