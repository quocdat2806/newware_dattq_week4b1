import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4b1/provider/timer_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => TimerProvider(),
      child:  MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(109, 234, 255, 1),
          colorScheme: const ColorScheme.light(
            secondary: Color.fromRGBO(72, 74, 126, 1),
          ),
        ),
        home:  Scaffold(
          appBar: AppBar(title: const Text('Flutter Timer'),centerTitle: true,),
          body: const SafeArea(
            child: Home(),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
      child: Consumer<TimerProvider>(
        builder: (context, couter, child) {
          if (!couter.isPause) {
            timer = Timer(const Duration(seconds: 0), () {
              couter.autoDecrease();
            });
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('00: ${couter.couter}',style: TextStyle(fontSize: 40),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  couter.isReply
                      ? Container(
                    padding: const EdgeInsets.all(10),

                        child: InkWell(
                            onTap: () {
                              couter.checkedEvent();
                            },
                            child: const Icon(Icons.skip_next_rounded,size: 50),
                          ),
                      )
                      : Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                child: couter.isPause
                                    ? const Icon(Icons.skip_next_rounded,size: 40,)
                                    : const Icon(Icons.pause,size: 40,),
                                onTap: () {
                                  couter.checkedEvent();
                                  timer?.cancel();
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                child: const Icon(Icons.refresh,size: 40,),
                                onTap: () {
                                  couter.replay();
                                  timer?.cancel();
                                },
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
