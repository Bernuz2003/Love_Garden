import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/garden_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('it');
  runApp(const ProviderScope(child: IlNostroGiardinoApp()));
}

class IlNostroGiardinoApp extends StatelessWidget {
  const IlNostroGiardinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Il Nostro Giardino',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const GardenScreen(),
    );
  }
}
