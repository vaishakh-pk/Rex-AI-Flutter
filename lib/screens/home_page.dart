import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rex_ai/services/openai_services.dart';
import 'package:rex_ai/widget/feature_box.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';

import '../misc/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? lastWords;
  final OpenAIService openaiservice = OpenAIService();
  FlutterTts flutterTts = FlutterTts();
  String? generatedContent;
  @override
  void initState() {
    
    super.initState();
  }



  Future<void> systemSpeak(String content) async
  {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
 @override
  Widget build(BuildContext context) {

    return Scaffold
    (
      appBar: AppBar(
        title: const Text('Rex-AI',textAlign: TextAlign.center,),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        backgroundColor: Pallete.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle,
                        ),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png'))
                    ),
                  )
                ],
              ),
            ),
      
            //Chat Bubble
            FadeInRight(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 30).copyWith(top: 20),
                  
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  )
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Text(
                    generatedContent == null ?'Good Morning, what can I do for you ?' : generatedContent!,
                  style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: generatedContent == null ? 20 : 18,
                    fontFamily: 'Cera Pro'
                  ),),
                ),
              ),
            ),
            SizedBox(height: 10,) ,
            SlideInLeft(
              child: Visibility(
                visible: generatedContent==null,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 5,left: 22),
                  alignment:Alignment.centerLeft ,
                  child: const Text('Here are some features :',style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 18,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
      
            //Features list
            Visibility(
              visible: generatedContent == null,
              child: Column(
                children: [
                   SlideInLeft(
                    delay: const Duration(microseconds: 200),
                     child: const FeatureBox(color: Pallete.firstSuggestionBoxColor,headerText: 'ChatGPT',
                     descriptionText: 'An easier way to stay connected and informed with ChatGPT',),
                   ),
                   // ignore: prefer_const_constructors
                   SlideInLeft(
                    delay: const Duration(microseconds: 300),
                     child: const FeatureBox(color: Pallete.secondSuggestionBoxColor,headerText: 'Dall-E',
                     descriptionText: 'Give life to your imagination and creativity using Dall-E',),
                   ),
                   SlideInLeft(
                    delay: const Duration(milliseconds: 400),
                     child: const FeatureBox(color: Pallete.thirdSuggestionBoxColor,headerText: 'Smart Voice Assistant',
                     descriptionText: 'Get the best of two worlds with voice assistant powered by Dall-E and ChatGPT',),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(microseconds: 600),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: ()
          async {
            await SpeechToTextGoogleDialog.getInstance()
                  .showGoogleDialog(onTextReceived: (data) async{
                    lastWords = data.toString();
                    generatedContent = await openaiservice.chatGPTAPI(lastWords!);
                  setState(() {
                  });
                  systemSpeak(generatedContent!);
                });
          },child: const Icon(Icons.mic),),
      ),
    );
  }
}