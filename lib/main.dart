import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:jollycast/core/provider/auth_controller.dart';
import 'package:jollycast/core/provider/episodes_controller.dart';
import 'package:jollycast/core/provider/audio_player_controller.dart';
import 'package:jollycast/core/auth/auth_wrapper.dart';
import 'package:jollycast/core/services/cache_service.dart';
import 'package:jollycast/core/services/connectivity_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cache service
  await CacheService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ConnectivityService()),
            ChangeNotifierProvider(create: (_) => AuthController()),
            ChangeNotifierProvider(create: (_) => EpisodesController()),
            ChangeNotifierProvider(create: (_) => AudioPlayerController()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jollycast',
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoTextTheme(),
              fontFamily: GoogleFonts.nunito().fontFamily,
            ),
            home: const AuthWrapper(),
          ),
        );
      },
    );
  }
}
