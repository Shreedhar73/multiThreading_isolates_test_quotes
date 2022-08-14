// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);

import 'dart:convert';

import 'dart:isolate';

List<Quotes> quotesFromJson(String str) => List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
    Quotes({
        this.text,
        this.author,
    });

    String? text;
    String? author;

    // List<Quotes> deserializeData(String text,){
    //   List<dynamic> dataMap = jsonDecode(text);
    //   return quotesFromJson(text);
    // }

    void deserializeData(List<dynamic> values){
      SendPort sendPort = values[0];
      String data = values[1];
      // var dataMap = jsonDecode(data);
      sendPort.send(quotesFromJson(data));

      
    }

    factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        text: json["text"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "author": author,
    };
}
