

import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:multithreading_test/quotesModel.dart';
import 'package:http/http.dart' as http;

class RemoteServices {

  var model = Quotes();



  static var client = http.Client();
  var quotesData = [];
  //

  Future<List<Quotes>> fetchQuotes() async {
    
    //   using compute
      // var response = await client.get(Uri.parse("https://type.fit/api/quotes"));

      // var _jsonDecode = response.body;

    //  return await compute(model.deserializeData,_jsonDecode);

    //using Isolate.spwan

    ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://type.fit/api/quotes"));

      // var _jsonDecode = response.body;
      final isolate = await Isolate.spawn <List<dynamic>>( model.deserializeData,[port.sendPort,response.body]);
      final x = await port.first;
      isolate.kill(priority: Isolate.immediate);
      return x;

    
  }
}
