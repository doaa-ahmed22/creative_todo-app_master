import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constantes/colors.dart';
import 'package:creative_app/screens/myhome_page.dart';
import 'package:creative_app/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..createDatabase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: MyColors.greyBackground,
        ),
        home: OnBoarding(),
      ),
    );
  }
}
