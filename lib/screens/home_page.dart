import 'package:flutter/material.dart';
import 'package:rex_ai/services/openai_services.dart';
import 'package:rex_ai/widget/feature_box.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../misc/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = 'speech';
  final OpenAIService openaiservice = OpenAIService();
  @override
  void initState() {
    
    super.initState();
    initSpeechToText();
  }

  Future <void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    print('now listening');
    setState(() {});
  }


  Future <void> stopListening() async {
    await speechToText.stop();
    print('stopped listening');
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> initSpeechToText() async
  {
    await speechToText.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
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
            Stack(
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
      
            //Chat Bubble
            Container(
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
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text('Good Morning, what can I do for you ?',
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontFamily: 'Cera Pro'
                ),),
              ),
            ),
            Container(
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
      
            //Features list
            const Column(
              children: [
                 FeatureBox(color: Pallete.firstSuggestionBoxColor,headerText: 'ChatGPT',
                 descriptionText: 'An easier way to stay connected and informed with ChatGPT',),
                 FeatureBox(color: Pallete.secondSuggestionBoxColor,headerText: 'Dall-E',
                 descriptionText: 'Give life to your imagination and creativity using Dall-E',),
                 FeatureBox(color: Pallete.thirdSuggestionBoxColor,headerText: 'Smart Voice Assistant',
                 descriptionText: 'Get the best of two worlds with voice assistant powered by Dall-E and ChatGPT',),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: ()
        async {
          if(await speechToText.hasPermission && speechToText.isNotListening)
          {
            await startListening();
          }
          else if(speechToText.isListening)
          {
            await stopListening();
            print(lastWords);
            openaiservice.isArtPromptAPI(lastWords);
          }
          else 
          {
            await initSpeechToText();
          }
        },child: const Icon(Icons.mic),),
    );
  }
}