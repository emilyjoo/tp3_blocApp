import 'package:bloc/bloc.dart';
import 'package:chatbot_gpt/model/chat.bot.model.dart';
import 'package:chatbot_gpt/repository/chat.bot.repository.dart';

abstract class ChatBotEvent{}
class AskLLMEvent extends ChatBotEvent{
  final String query;
  AskLLMEvent({ required this.query});

}



abstract class ChatBotState{
  final List<Message> messages;

  ChatBotState({required this.messages});

}
class ChtBotPendingState extends ChatBotState{
  ChtBotPendingState({required super.messages});


}
class ChatBotSuccessState extends  ChatBotState{
  ChatBotSuccessState({required super.messages});

}
class ChatBotErrorState extends  ChatBotState{
  final String errorMessage;
  ChatBotErrorState({required super.messages,required this.errorMessage});

}
class ChatBotInitialState extends ChatBotState{
  ChatBotInitialState():super(messages: [
    Message(message: "Hello", type: "user" ),
    Message(message: "How can i help you", type: "assistant" ),


  ]);

}
class ChatBotBloc extends Bloc<ChatBotEvent,ChatBotState>{
  final ChatBotRepositry chatBotRepositry =ChatBotRepositry();
  late ChatBotEvent lastEvent;
  ChatBotBloc():super(ChatBotInitialState()){
    on((AskLLMEvent event,emit) async{
      print("AskLLMEvent occured");
      lastEvent =event;
      List<Message> currentMessages =state.messages;
      emit(ChtBotPendingState(messages: state.messages ));
      currentMessages.add(Message(message: event.query, type:"user"));

      try {
        Message responseMessage =await chatBotRepositry.askLargeLangueModelGPT(event.query);

        currentMessages.add(responseMessage);
        emit(ChatBotSuccessState(messages: currentMessages));
      } catch (e) {
       emit(ChatBotErrorState(messages:state.messages, errorMessage:e.toString()));
      }
    }
    );

  }

}
