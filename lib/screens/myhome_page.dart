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
              child: appBarNotification(context),
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
                            // cubit.toggleDone(index);
                          },
                          icon: Icon(
                            cubit.taskNotDone,
                            color: cubit.colorTypes.keys.firstWhere(
                                (k) =>
                                    cubit.colorTypes[k] ==
                                    cubit.data[index]['type'],
                                orElse: () => Colors.red),
                            size: 24,
                          ),
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
