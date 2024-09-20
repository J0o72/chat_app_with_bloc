import 'package:chat_app_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app_bloc/blocs/bloc_observer.dart';
import 'package:chat_app_bloc/cubits/auth_cubit.dart';
import 'package:chat_app_bloc/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app_bloc/firebase_options.dart';
import 'package:chat_app_bloc/pages/chat_page.dart';
import 'package:chat_app_bloc/pages/login_page.dart';
import 'package:chat_app_bloc/pages/resigter_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // BlocOverrides.runZoned(() {
  //   runApp(const ChatApp());
  // }, blocObserver: SimpleBlocObserver());

  // New way
  Bloc.observer = SimpleBlocObserver();

  runApp(const ChatApp());

  // Bloc.observer;
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        routes: {
          'LoginPage': (context) => LoginPage(),
          'resigterPage': (context) => const ResigterPage(),
          'chatPage': (context) => ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'LoginPage',
      ),
    );
  }
}
