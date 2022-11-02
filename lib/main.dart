import 'package:aula/blocs/favoritos_bloc.dart';
import 'package:aula/blocs/video_bloc.dart';
import 'package:aula/screens/home.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const YouFlutter());
}

class YouFlutter extends StatelessWidget {
  const YouFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoritosBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "YouFlutter",
        home: Home(),
      ),
      
    );
  }
}