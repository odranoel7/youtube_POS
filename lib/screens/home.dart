import 'package:aula/delegates/data_search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/youtube_logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(
            onPressed: () {
            }, 
            icon: Icon(Icons.stars),
          ),
          IconButton(
            onPressed: () async {
              String? result = await showSearch(context: context, delegate: DataSearch());
              print(result);
            }, 
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        child: Text("Lista de Vídeos"),
      ),

    );
  }
}