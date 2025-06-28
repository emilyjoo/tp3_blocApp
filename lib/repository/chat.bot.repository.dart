import 'dart:convert';

import 'package:chatbot_gpt/model/chat.bot.model.dart';
import 'package:http/http.dart' as http;

class ChatBotRepositry {
  Future<Message> askLargeLangueModelGPT(String query)async{
    var url ="https://api.openai.com/v1/chat/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer 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" // ← Clé intégrée directement
    };
    var prompt = {
    "model": "gpt-3.5-turbo",
    "messages": [
    {"role": "user", "content": query}
    ],
    "temperature": 0
    };
    try{
    http.Response response =await http.post(Uri.parse(url),
    headers: headers, body: json.encode(prompt));
    if(response.statusCode==200){
    Map<String,dynamic> result = jsonDecode(response.body);
    Message message=Message(message: result['choices'][0]['message']['content'], type:"assistant");
    return message;

    }
    else{
    return throw("Error ${response.statusCode}");
    }

    } catch(err){

    return throw("Error ${err.toString()}");
    }

  }
}