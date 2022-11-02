

import 'package:aula/api.dart';
import 'package:aula/blocs/favoritos_bloc.dart';
import 'package:aula/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideoTile extends StatelessWidget {
  
  Video video = Video('', '', '', '');
  
  VideoTile(this.video);


  @override
  Widget build(BuildContext context) {
    final FavoritosBloc favBloc = BlocProvider.getBloc<FavoritosBloc>();

    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
          apiKey: API_KEY, 
          videoId: video.id
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //OCUPAR A TELA TODA
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0/9.0,
              child: Image.network(
                video.thumb, 
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Text(
                          video.channel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                    
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: favBloc.outFav,
                  initialData: {},
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          favBloc.toggleFavorito(video);
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}