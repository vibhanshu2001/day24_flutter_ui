import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url="https://swapi.dev/api/people";
  List data;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }
  Future<String> getJsonData() async{
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );
    setState(() {
      var convertDatatoJson = jsonDecode(response.body);
      data = convertDatatoJson['results'];
    });
    return "Success";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve Json using Http Get"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: data==null?0:data.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        data[index]['name']
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

