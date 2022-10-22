

import 'package:aula/models/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  
  Video video = Video('', '', '', '');
  
  VideoTile(this.video);


  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //OCUPAR A TELA TODA
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(video.thumb, fit: BoxFit.cover),
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
              IconButton(
                icon: Icon(Icons.star_border),
                color: Colors.white,
                onPressed: () {

                },
              ),
            ],
          ),
        ],
      ),
    );


    throw UnimplementedError();
  }
  
}