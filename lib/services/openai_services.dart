import 'dart:convert';

import 'package:http/http.dart' as http;
import '../keys/apikeys.dart';

class OpenAIService
{
  final List<Map<String , String>> messages = [];

  Future <String> isArtPromptAPI(String prompt) async
  {
    try
    {

      print('checking in api');

      final res = await http.post(
        Uri.parse('https://api.pawan.krd/v1/chat/completions'),
        headers: 
        {
          'Authorization': 'Bearer pk-***$openApiKey***',
          'Content-Type': 'application/json',
        },

        body: jsonEncode(
          {
             "model": "pai-001-light-beta",
             "max_tokens": 100,
            "messages": 
            [
              {
                "role": "user", 
                "content": "Does this message want to generate an AI art or similar? $prompt. answer in single word yes or no"
              }
            ]
          }
        )

      );


        print(res.body);
        if(res.statusCode == 200)
        {
          String content = jsonDecode(res.body)['choices'][0]['message']['content'];
          content = content.trim();
          if(content.contains('yes') || content.contains('Yes'))
          {
            final res = await dallEAPI(prompt);
            return res;
          }
          else
          {
            final res = await chatGPTAPI(prompt);
            return res;
          }
        }
        return "An error occurred";
    }
    catch(e)
    {
      return e.toString();
    }
  }


//ChatGPT Model

  Future <String> chatGPTAPI(String prompt) async
  {

    messages.add({
      'role':'user',
      'content': prompt,
    });

    try{
          final res = await http.post(
        Uri.parse('https://api.pawan.krd/v1/chat/completions'),
        headers: 
        {
          'Authorization': 'Bearer pk-***$openApiKey***',
          'Content-Type': 'application/json',
        },

        body: jsonEncode(
          {
             "model": "pai-001-light-beta",
             "max_tokens": 100,
            "messages": messages
          }
        )

      );

        if(res.statusCode == 200)
        {
          String content = jsonDecode(res.body)['choices'][0]['message']['content'];
          content = content.trim();
          
          messages.add(
            {
              'role' : 'assistan',
              'content' : content
            }
          );
          return content;
        }
        return "An error occurred";
    }
    catch(e)
    {
      return e.toString();
    }
  }

  //Dall-E Model

  Future <String> dallEAPI(String prompt) async
  {
    return 'DallE';
  }

  Future <void> testAPI() async
  {
    final res = await http.post(
        Uri.parse('https://api.pawan.krd/v1/chat/completions'),
        headers: 
        {
          'Authorization': 'Bearer pk-***$openApiKey***',
          'Content-Type': 'application/json',
        },

        body: jsonEncode(
          {
             "model": "pai-001-light-beta",
             "max_tokens": 100,
            "messages": 
            [
              {
                "role": "user", 
                "content": "Hi, good morning"
              }
            ]
          }
        )
    );


    bool status = jsonDecode(res.body)['status'];

    if(!status)
    {
      resetAPI();
    }

  }

  Future<void> resetAPI() async
  {
    final res = await http.post(
        Uri.parse('https://api.pawan.krd/resetip'),
        headers: 
        {
          'Authorization': 'Bearer pk-***$openApiKey***'
        }
    );

    print(res.body);
  }
}