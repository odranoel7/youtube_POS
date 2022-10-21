import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate <String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      }, 
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((v) => close(context, query));

    return Container();
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty){
      return Container();
    } else {
      return FutureBuilder <List> (
        future: suggestions(query), 
        builder: (context, snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]),
                  leading: Icon(Icons.play_circle_filled),
                  onTap: () {
                    close(context, snapshot.data?[index]);
                  },
                );
              },
              itemCount: snapshot.data?.length,
            );
          }
        },
      );
    }
  }

  Future<List> suggestions(String search) async {
    if (search != ''){
      http.Response response = await http.get(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)[1].map((value) {
          return value[0];
        }).toList();
      } else {
        throw Exception("Failed to load suggestios");
      }

    } else {
      return [];
    }
  }


}