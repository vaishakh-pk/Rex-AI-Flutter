import 'package:flutter/material.dart';
import 'package:rex_ai/widget/feature_box.dart';

import '../pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4),
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
              horizontal: 40).copyWith(top: 30),

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
                vertical: 10,
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
            margin: const EdgeInsets.only(top: 10,left: 22),
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
               descriptionText: 'An easier way to stay connected and informed with ChatGPT',)
            ],
          )

        ],
      ),
    );
  }
}