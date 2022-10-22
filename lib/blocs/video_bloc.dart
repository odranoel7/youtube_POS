import 'dart:async';
import 'dart:ui';

import 'package:aula/api.dart';
import 'package:aula/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class VideosBloc implements BlocBase {
  Api api = Api();
  List<Video> videos = [];
  final StreamController _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final StreamController _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    _searchController.stream.listen(_search);
  }

  void _search(dynamic search ) async {
    videos = await api.search(search);

    _videosController.sink.add(videos);
  }
  
  @override
  void dispose() {
    _videosController.close();
    
  }
  
  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }
  
  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();
  
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }
  
  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  } 
}