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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // SqfLiteApp sqfLiteApp = SqfLiteApp();

  var intIndex = 0;

  //
  // Future getDatabase() async {
  //   List<Map> response = await sqfLiteApp.getDatabase();
  //   data.addAll(response);
  //   isLoading = false;
  //   if (this.mounted) setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var tasks = AppCubit.get(context).data;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(210),
            child: appBarNotification(context),
          ),
          body: cubit.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                                color: Colors.red,
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
                                        state: cubit.data[index]['state'],
                                        time: cubit.data[index]['time'],
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
                                Text(
                                  cubit.data[index]['time'],
                                  style: TextStyle(
                                      color: MyColors.textGrey, fontSize: 12),
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
                        itemCount: tasks.length,
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
