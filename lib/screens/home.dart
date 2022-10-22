import 'dart:ui';

import 'package:aula/blocs/video_bloc.dart';
import 'package:aula/delegates/data_search.dart';
import 'package:aula/widgets/videotile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final VideosBloc videosBloc = BlocProvider.getBloc<VideosBloc>();

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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
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