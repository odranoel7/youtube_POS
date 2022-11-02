import 'package:aula/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../blocs/favoritos_bloc.dart';
import '../models/video.dart';

class Favoritos extends StatelessWidget {
  const Favoritos({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritosBloc favBloc = BlocProvider.getBloc<FavoritosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        stream: favBloc.outFav,
        initialData: {},
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            children: snapshot.data.values.map((value) {
              return InkWell(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(value.thumb),
                    ),
                    Expanded(
                      child: Text(
                        value.title,
                        style: TextStyle(
                          color: Colors.white
                        ),
                        maxLines: 2,
                      )
                    ),
                  ],
                ),
                onLongPress: () { //REMOVER O VÍDEO DA LISTA
                  favBloc.toggleFavorito(value);
                },
                onTap: () { //ABRIR O VÍDEO
                  FlutterYoutube.playYoutubeVideoById(
                    apiKey: API_KEY, 
                    videoId: value.id
                  );
                },
              );
            }).toList(),
          );
        },
      ),





    );
  }
}