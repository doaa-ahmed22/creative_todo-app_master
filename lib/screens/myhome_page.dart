import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:creative_app/widgets/my_appbar.dart';
import 'package:creative_app/widgets/navigator_button.dart';
import 'package:creative_app/widgets/plus_button.dart';
import 'package:creative_app/widgets/update.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // SqfLiteApp sqfLiteApp = SqfLiteApp();

  var intIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: cubit.isLoading,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(210),
              child: NewGradientAppBar(
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPaint(
                      painter: CircleOne(),
                    ),
                    CustomPaint(
                      painter: CircleTwo(),
                    ),
                  ],
                ),
                title: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello Doaa!',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'You have ${AppCubit.get(context).data.length} tasks',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/photo.jpg',
                      ),
                    ),
                  )
                ],
                elevation: 5,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColors.headerBlueDark, MyColors.headerBlueLight],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(10),
                  child: Container(
                    height: 115,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: MyColors.headerGreyLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Today Reminder',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                cubit.data.length > 0
                                    ? '${cubit.data[0]['title']}'
                                    : 'Tasks Loading',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                cubit.data.length > 0
                                    ? 'Task Time: ${cubit.data[0]['time']}'
                                    : '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 75,
                          ),
                          width: MediaQuery.of(context).size.width / 2.9,
                          child: Image.asset(
                            'assets/images/bell-left.png',
                            scale: .2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 80,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.clear,
                              color: MyColors.greyBorder,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, bottom: 15),
                    child: Text(
                      'Manage Your Time ',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: MyColors.textSubHeader),
                    ),
                  ),
                  ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          stops: [0.015, 0.015],
                          colors: [MyColors.yellowIcon, Colors.white],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [boxShadow(MyColors.greyBorder)],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            cubit.toggleDone(index);
                          },
                          icon: cubit.taskIcons[index],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                    title: cubit.data[index]['title'],
                                    date: cubit.data[index]['date'],
                                    time: cubit.data[index]['time'],
                                    type: cubit.data[index]['type'],
                                    id: cubit.data[index]['id']),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.blue,
                          ),
                        ),
                        title: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  cubit.data[index]['date'],
                                  style: TextStyle(
                                      color: MyColors.textGrey, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  cubit.data[index]['time'],
                                  style: TextStyle(
                                      color: MyColors.textGrey, fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                cubit.data[index]['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: cubit.data.length,
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: PlusButton(),
            bottomNavigationBar: NavigatorButton(
              context: context,
              intIndex: intIndex,
            ),
          ),
        );
      },
    );
  }
}
