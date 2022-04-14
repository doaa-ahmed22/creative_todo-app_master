import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:creative_app/widgets/my_appbar.dart';
import 'package:creative_app/widgets/navigator_button.dart';
import 'package:creative_app/widgets/plus_button.dart';
import 'package:creative_app/widgets/update.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListTasks extends StatefulWidget {
  @override
  State<MyListTasks> createState() => _MyListTasksState();
}

class _MyListTasksState extends State<MyListTasks> {
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
        var tasks = AppCubit.get(context).myTasks;
        return Scaffold(
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
                    'Today',
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.panorama_fish_eye,
                          color: cubit.colorTypes.keys.firstWhere(
                              (k) =>
                                  cubit.colorTypes[k] ==
                                  cubit.myTasks[index]['type'],
                              orElse: () => Colors.red),
                          size: 24,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                  title: cubit.myTasks[index]['title'],
                                  date: cubit.myTasks[index]['date'],
                                  time: cubit.myTasks[index]['time'],
                                  type: cubit.myTasks[index]['type'],
                                  id: cubit.myTasks[index]['id']),
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
                                cubit.myTasks[index]['date'],
                                style: TextStyle(
                                    color: MyColors.textGrey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                cubit.myTasks[index]['time'],
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
                              cubit.myTasks[index]['title'],
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
                  itemCount: cubit.myTasks.length,
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
        );
      },
    );
  }
}
