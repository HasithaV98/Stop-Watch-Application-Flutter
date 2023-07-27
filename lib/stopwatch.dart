import 'dart:async';

import 'package:flutter/material.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  int seconds = 0, minutes = 0, hour = 0;
  String digitalSeconds = '00', digitalMinute = '00', digitalHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int loclMinutes = minutes;
      int localHours = hour;

      if (localSeconds > 59) {
        if (loclMinutes > 59) {
          localHours++;
          loclMinutes = 0;
        }
      } else {
        loclMinutes++;
        localSeconds = 0;
      }
      setState(() {
        seconds = localSeconds;
        minutes = loclMinutes;
        hour = localHours;
        digitalSeconds = (seconds >= 10) ? "$seconds" : "$seconds";
        digitalMinute = (minutes >= 10) ? "$minutes" : "$minutes";
        digitalHours = (hour >= 10) ? "$hour" : "$hour";
      });
    });
  }

  void addLaps() {
    String lap = "$digitalHours:$digitalMinute:$digitalSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hour = 0;
      digitalSeconds = '00';
      digitalMinute = '00';
      digitalHours = '00';

      started = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Stop Watch',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  '$digitalHours:$digitalMinute:$digitalSeconds',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 85.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lap n' ${index + 1}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                            Text(
                              " ${laps[index]}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            )
                          ],
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.orange),
                    ),
                    child: Text(
                      (!started) ? 'START' : "PAUSE",
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  const SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        addLaps();
                      },
                      icon: const Icon(Icons.flag)),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.orange,
                    shape: const StadiumBorder(),
                    child: const Text(
                      'RESET',
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
                ],
              )
            ],
          ),
        )));
  }
}
