import 'package:bloc/bloc.dart';

import '../apicall.dart';

class QuotesCubit extends Cubit<dynamic>{
  QuotesCubit() : super(null);

  void getQuotes() {
    RemoteServices().fetchQuotes().then((value) {
      emit(value);
    });
  }

  // void deleteQuotes(){
  //   emit(null);
  // }

}