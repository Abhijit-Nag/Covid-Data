import 'dart:convert';

import 'package:covid_tracker_app/models/WorldStatesModel.dart';
import 'package:covid_tracker_app/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StatesServices{

//   Future<WorldStatesModel> fetchWorldStatesRecord() async{
//   final response = await http.get(Uri.parse(AppUrl.worldStatesAPI));
//   print('api called!');
//
//   if(response.statusCode==200){
//     final data= jsonDecode(response.body);
//     return WorldStatesModel.fromJson(data);
//
//   }else{
// throw Exception('error');
//   }
//   }


  Future<dynamic> fetchWorldStatesRecord() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesAPI));
    print(jsonDecode(response.body)['updated']);
    print('api called!');

    if(response.statusCode==200){
      final data= jsonDecode(response.body);
      return data;

    }else{
      throw Exception('error');
    }
  }

  Future<List<dynamic>>countriesListApi()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    print('api called!');
    if(response.statusCode==200){
       data= jsonDecode(response.body);
       return data;
    }else{
      throw Exception('Error');
    }
  }
}