import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:aula/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosBloc implements BlocBase {
  Map<String, Video> _favoritos = {};

  final _favController = BehaviorSubject<Map<String, Video>>.seeded({});
  Stream<Map<String, Video>> get outFav =>_favController.stream;

  FavoritosBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favoritos")) {
        _favoritos = json.decode(prefs.getString("favoritos")).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();
        _favController.add(_favoritos);
      }
    });
  }

  void toggleFavorito(Video video) {
    if (_favoritos.containsKey(video.id)) {
      _favoritos.remove(video.id);
    } else {
      _favoritos[video.id] = video;
    }

    _favController.sink.add(_favoritos);

    _saveFavoritos();
  }

  void _saveFavoritos() {
    SharedPreferences.getInstance().then((pref) {
      pref.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void dispose() {
    _favController.close();
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