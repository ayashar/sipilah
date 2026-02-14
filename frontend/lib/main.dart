import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'website/pages/overview.dart';
import 'website/pages/analytics.dart';
import 'website/pages/keuangan.dart';
import 'package:frontend/mobile/mobile_home_screen.dart';
import 'package:frontend/shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: WasteManagementApp()));
}

class WasteManagementApp extends StatelessWidget {
  const WasteManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Management',
      debugShowCheckedModeBanner: false,
      theme: kIsWeb
          ? ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
              textTheme: GoogleFonts.urbanistTextTheme(),
            )
          : AppTheme.mobileTheme,
      home: const PlatformGuard(),
      initialRoute: kIsWeb ? '/overview' : null,

      routes: kIsWeb
          ? {
              '/overview': (context) => const OverviewPage(),
              '/analytics': (context) => const AnalyticsPage(),
              '/keuangan': (context) => const KeuanganPage(),
            }
          : {},
    );
  }
}

class PlatformGuard extends StatelessWidget {
  const PlatformGuard({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const AdminFacade();
    } else {
      return const MobileHomeScreen();
    }
  }
}

class AdminFacade extends StatelessWidget {
  const AdminFacade({super.key});

  @override
  Widget build(BuildContext context) {
    return const OverviewPage();
  }
}
