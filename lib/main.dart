import 'package:flix_movie_app/injector.dart';
import 'package:flix_movie_app/provider/movie_get_discover_provider.dart';
import 'package:flix_movie_app/provider/movie_get_top_rated_provider.dart';
import 'package:flix_movie_app/provider/movie_now_playing_provider.dart';
import 'package:flix_movie_app/screens/movie_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(const App());

  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MovieGetNowPlayingProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flix App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          // scaffoldBackgroundColor:
          //     const Color(0xFF1679AB), // Set background color to blue
          // primaryColor: Color(0xFF1679AB),
        ),
        home: const MovieHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
