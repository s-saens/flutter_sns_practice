import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_practice/firebase_options.dart';
import 'package:flutter_sns_practice/pages/page_home.dart';
import 'package:flutter_sns_practice/pages/page_login.dart';
import 'package:flutter_sns_practice/pages/page_register.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

myTransitionPage(GoRouterState state, Widget child, Offset offset) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: offset, end: Offset.zero).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuint,
        )),
        child: child,
      );
    },
  );
}

class MyApp extends ConsumerWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => myTransitionPage(state, const LoginPage(), const Offset(-1, 0)),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => myTransitionPage(state, const RegisterPage(), const Offset(1, 0)),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => myTransitionPage(state, const HomePage(), const Offset(-1, 0)),
      ),
    ],
  );

  MyApp({super.key});

  final seedColorProvider = StateProvider((ref) => Colors.blue);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color themeSeedColor = ref.watch(seedColorProvider);
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.light, seedColor: themeSeedColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: themeSeedColor),
      ),
    );
  }
}
