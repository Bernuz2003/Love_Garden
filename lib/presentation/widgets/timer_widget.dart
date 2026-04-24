import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final DateTime _startDate = DateTime(2025, 10, 4);
  late Timer _timer;
  Duration _difference = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      _difference = DateTime.now().difference(_startDate);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_difference.isNegative) {
      return _buildCard('In attesa...');
    }

    final days = _difference.inDays;
    final hours = _difference.inHours % 24;
    final minutes = _difference.inMinutes % 60;

    return _buildCard('$days giorni, $hours ore, $minutes min');
  }

  Widget _buildCard(String timeText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x99FFFFFF), Color(0x66FFFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          const Text(
            'Piccolissimi insieme',
            style: TextStyle(
              color: Color(0xFFAD1457),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          // Timer row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('💕', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Text(
                timeText,
                style: const TextStyle(
                  color: Color(0xFF4E342E),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
