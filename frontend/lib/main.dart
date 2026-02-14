import 'package:flutter/foundation.dart'; // Needed for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'website/pages/overview.dart';

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

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.urbanistTextTheme(),
      ),

      initialRoute: '/overview',

      routes: {
        '/overview': (context) => const OverviewPage(),
        // '/analytics': (context) => const AnalyticsPage(),
        // '/keuangan': (context) => const KeuanganPage(),
      },
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
      return const MobileFacade();
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

class MobileFacade extends StatelessWidget {
  const MobileFacade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(title: const Text("WASTE APP (Mobile Only)")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text("Welcome, User.", style: TextStyle(fontSize: 24)),
            Text("Flow 1 & 2: Household & Collector"),
          ],
        ),
      ),
    );
  }
}

