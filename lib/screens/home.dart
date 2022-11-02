import 'dart:ui';

import 'package:aula/blocs/favoritos_bloc.dart';
import 'package:aula/blocs/video_bloc.dart';
import 'package:aula/delegates/data_search.dart';
import 'package:aula/screens/favoritos.dart';
import 'package:aula/widgets/videotile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final VideosBloc videosBloc = BlocProvider.getBloc<VideosBloc>();
    final FavoritosBloc favBloc = BlocProvider.getBloc<FavoritosBloc>();

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
            child: StreamBuilder(
              stream: favBloc.outFav,
              initialData: {},
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data.length}");
                } else {
                  return Text("0");
                }
              },

            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Favoritos(),
              ));
            }, 
            icon: Icon(Icons.stars),
          ),
          IconButton(
            onPressed: () async {
              String? result = await showSearch(context: context, delegate: DataSearch());
              if (result != null ) {
                videosBloc.inSearch.add(result);
              }
            }, 
            icon: Icon(Icons.search),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: videosBloc.outVideos,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1){
                  videosBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    )
                  );
                } else {
                  return Container(
                    child: Text(
                      "Busque pelo termo de seu video",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  );
                }
              },
              itemCount: snapshot.data.length+1,
            );
          } else {
            return Center(
              child: Text(
                'Busque um vídeo',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            );
          }
        }
      ),

    );
  }
}