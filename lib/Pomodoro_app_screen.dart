import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({Key? key}) : super(key: key);

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  Timer? repeatedFunction; //global variable

  Duration duration = const Duration(minutes: 25);

  startTimer() {
    repeatedFunction = Timer.periodic(const Duration(seconds: 1), (timer) {
      // timer => local variable
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel(); // or => timer.cancel();
          setState(() {
            duration = const Duration(minutes: 25);
            isRuning = false;
          });
        }
      });
    });
  }

  bool isRuning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff483F47),
        appBar: AppBar(
          title: const Text(
            "Pomodoro App",
            style: TextStyle(
                fontSize: 32,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  progressColor: const Color.fromARGB(255, 255, 85, 113),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  lineWidth: 8.0,
                  percent: duration.inMinutes / 25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  radius: 120.0,
                  center: Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                    style: const TextStyle(fontSize: 65, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            isRuning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (repeatedFunction!.isActive) {
                            setState(() {
                              repeatedFunction!.cancel();
                            });
                          } else {
                            startTimer();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 55, 120, 197)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(14)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9))),
                        ),
                        child: Text(
                          (repeatedFunction!.isActive) ? "Stop" : "Resume",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          repeatedFunction!.cancel();
                          setState(() {
                            duration = const Duration(minutes: 25);
                            isRuning = false;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 55, 120, 197)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(14)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9))),
                        ),
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRuning = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 55, 120, 197)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11))),
                    ),
                    child: const Text(
                      "Start Studying",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
          ],
        ));
  }
}
