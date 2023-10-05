import 'dart:convert';

import 'package:http/http.dart' as http;
import '../keys/apikeys.dart';

class OpenAIService
{
  Future <String> isArtPromptAPI(String prompt) async
  {
    try
    {

      print('checking in api');

      final res = await http.post(
        Uri.parse('https://api.pawan.krd/v1/completions'),
        headers: 
        {
          'Authorization': 'Bearer pk-***$openApiKey***',
          'Content-Type': 'application/json',
        },

        body: jsonEncode(
          {
             "model": "gpt-3.5-turbo",
             "max_tokens": 100,
            "messages": 
            [
              {
                "role": "user", 
                "content": "Does this message want to generate an AI art or similar? $prompt. answe in yes or no"
              }
            ]
          }
        )

      );


    //   final res = await http.post(
    //     Uri.parse('https://api.openai.com/v1/chat/completions'),
    //     headers: 
    //     {
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Bearer $openApiKey'
    //     },
    //     body: jsonEncode({
    //       "model": "gpt-3.5-turbo",
    //       "messages": [
    //   {
    //     "role": "user",
    //     "content": "Does this message want to generate an AI art or similar? $prompt. answe in yes or no"
    //   },
    // ],
    //     }),
    //     );
        print(res.body);
        if(res.statusCode == 200)
        {
          print('\n\nyay success');
        }
        return "AI";
    }
    catch(e)
    {
      return e.toString();
    }
  }
  // Future <String> chatGPTAPI(String prompt) async{}
  // Future <String> dallEAPI(String prompt) async{}
}