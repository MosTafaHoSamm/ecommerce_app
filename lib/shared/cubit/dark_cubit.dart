import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit/dark_states.dart';


class HomeCubit extends Cubit<HomeStates>{
  HomeCubit ():super(InitialHomeStates());
  static HomeCubit get(context)=>BlocProvider.of(context);
 int current=0;
  void dotSlide( index){
    current=index;
          emit(ChangeHomeStates());



    }




}