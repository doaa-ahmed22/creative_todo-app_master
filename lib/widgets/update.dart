import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/screens/myhome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sqflite.dart';

class UpdateScreen extends StatefulWidget {
  final title;
  late final time;
  late final date;
  late final state;
  late final id;

  UpdateScreen(
      {required this.title,
      required this.date,
      required this.state,
      required this.time,
      required this.id});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  //SqfLiteApp sqfLiteApp = SqfLiteApp();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    timeController.text = widget.time;
    dataController.text = widget.date;
    stateController.text = widget.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('UpdateScreen'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(hintText: 'enter title'),
                    ),
                    TextFormField(
                      controller: dataController,
                      decoration: InputDecoration(hintText: 'enter date'),
                    ),
                    TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(hintText: 'enter time'),
                    ),
                    TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(hintText: 'enter state'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        int response = await cubit.updateDatabase(
                          title: titleController.text,
                          date: dataController.text,
                          time: timeController.text,
                          status: stateController.text,
                          id: widget.id,
                        );
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                              (route) => false);
                        }
                        print('ooooooooooooooo');
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('update'),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
