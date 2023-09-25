import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerProvider extends ChangeNotifier{
  int couter  =  60;
  bool isReply = false;
  bool isPause  = false;
  void autoDecrease(){
    couter = couter - 1;
    if(couter < 0){
      couter = 60 ;
    }
    Future.delayed(const Duration(seconds: 1),(){
      notifyListeners();

    });
  }
  void checkedEvent(){
    isReply = false;
    isPause = !isPause;
    notifyListeners();
    // if(!isPause){
    //   timer.cancel();
    // }
  }


  void replay(){
    couter = 60;
    isPause = true;
    isReply = true;
    notifyListeners();
  }


}