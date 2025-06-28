import 'dart:convert';
import 'dart:io';

import 'package:chatbot_gpt/bloc/chat.bot.bolc..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChatBotPage extends StatelessWidget {
  ChatBotPage({super.key});

  TextEditingController queryController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header moderne avec glassmorphism
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Chat Bot",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Zone de chat avec glassmorphism
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BlocBuilder<ChatBotBloc, ChatBotState>(
                      builder: (context, state) {
                        if (state is ChtBotPendingState) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667eea)),
                                    strokeWidth: 3,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Traitement en cours...",
                                    style: TextStyle(
                                      color: Color(0xFF2d3436),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is ChatBotErrorState) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.1),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Color(0xFFe17055),
                                    size: 48,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "${state.errorMessage}",
                                    style: TextStyle(
                                      color: Color(0xFFe17055),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF667eea).withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ChatBotEvent evt = context.read<ChatBotBloc>().lastEvent;
                                        context.read<ChatBotBloc>().add(evt);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.refresh, color: Colors.white, size: 20),
                                          SizedBox(width: 8),
                                          Text(
                                            "Réessayer",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is ChatBotSuccessState || state is ChatBotInitialState) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) {
                                bool isUser = state.messages[index].type == 'user';
                                return Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    mainAxisAlignment: isUser
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (!isUser) ...[
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Icon(
                                            Icons.support_agent,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                      ],
                                      Flexible(
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: isUser
                                                ? Colors.white.withOpacity(0.9)
                                                : Colors.white.withOpacity(0.95),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(isUser ? 20 : 4),
                                              bottomRight: Radius.circular(isUser ? 4 : 20),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            border: isUser
                                                ? Border.all(
                                              color: Color(0xFF667eea).withOpacity(0.3),
                                              width: 1.5,
                                            )
                                                : null,
                                          ),
                                          child: Text(
                                            state.messages[index].message,
                                            style: TextStyle(
                                              color: Color(0xFF2d3436),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (isUser) ...[
                                        SizedBox(width: 12),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFFf093fb), Color(0xFF764ba2)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),

              // Zone de saisie avec glassmorphism
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: queryController,
                          style: TextStyle(
                            color: Color(0xFF2d3436),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "Tapez votre message...",
                            hintStyle: TextStyle(
                              color: Color(0xFF636e72),
                              fontSize: 16,
                            ),
                            prefixIcon: Container(
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.chat_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFF667eea),
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFf093fb)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF667eea).withOpacity(0.4),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          String query = queryController.text;
                          if (query.trim().isNotEmpty) {
                            context.read<ChatBotBloc>().add(AskLLMEvent(query: query));
                            queryController.text = "";
                          }
                        },
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}