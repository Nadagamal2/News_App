
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';



import 'layout/news_app/cubit/cubit.dart';
import 'shared/components/constants.dart';


void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
        ()async {

      DioHelper.init();
      await CasheHelper.init();
      bool? isDark=CasheHelper.getData(key:'isDark');



      // Use cubits...
      runApp( MyApp(
        isDark: isDark,

      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget
{

  final bool? isDark;

  MyApp({
    this.isDark,
   });
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context)=>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStates> (
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme:darkTheme ,
            themeMode:NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home:NewsLayout(),
          );
        },
      ),
    );

  }

}