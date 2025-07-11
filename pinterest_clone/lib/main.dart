import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_post_screen.dart';
import 'screens/edit_post_screen.dart';
import 'screens/discover_screen.dart';
import 'screens/pembaruan_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/account_screen.dart';

import 'models/post_model.dart';
import 'providers/post_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        title: 'Pinterest Clone',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/add': (context) => const AddPostScreen(),
          '/discover': (context) => const DiscoverScreen(),
          '/pembaruan': (context) => const PembaruanScreen(),
          '/chat': (context) => const ChatScreen(),
          '/account': (context) => const AccountScreen(),
        },
        // Untuk route yang membutuhkan parameter seperti EditPostScreen
        onGenerateRoute: (settings) {
          if (settings.name == '/edit') {
            final post = settings.arguments as PostModel;
            return MaterialPageRoute(
              builder: (context) => EditPostScreen(post: post),
            );
          }
          return null;
        },
      ),
    );
  }
}
