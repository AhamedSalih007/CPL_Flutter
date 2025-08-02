import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration time;
  const CountdownTimer({super.key, required this.time});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.time;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime = _remainingTime - const Duration(seconds: 1);
      } else {
        _timer.cancel(); // Stop the timer when countdown completes
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(_remainingTime),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}
