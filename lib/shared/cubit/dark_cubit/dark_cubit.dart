import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/signupModel.dart';
import '../../components/constatnts.dart';
import '../home_states.dart';
import 'dark_states.dart';

class DarkCubit extends Cubit<DarkStates>{
  DarkCubit ():super(InitialDarkStates());
  static DarkCubit get(context)=>BlocProvider.of(context);
  bool isDark=false;

  void changeMode({bool? fromShared}){
    if(fromShared!=null)
      {
        isDark=fromShared;
        emit(ChangeDarkStates());
      }
    else{
      isDark=!isDark;
      CacheHelper.saveBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeDarkStates());

      });

    }

  }




}