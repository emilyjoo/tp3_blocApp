import 'package:chatbot_gpt/bloc/chat.bot.bolc..dart';
import 'package:chatbot_gpt/chat.bot.page.dart';
import 'package:chatbot_gpt/home.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp()); // Suppression du chargement de .env
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatBotBloc())
      ],
      child: const RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        indicatorColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/chat": (context) =>  ChatBotPage(),
      },
      home: HomePage(),
    );
  }
}