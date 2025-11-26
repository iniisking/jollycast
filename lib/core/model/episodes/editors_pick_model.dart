import 'package:jollycast/core/model/episodes/get_trending_model.dart';

class EditorsPickRes {
  final String message;
  final EditorsPickData data;

  EditorsPickRes({required this.message, required this.data});
}

class EditorsPickData {
  final String message;
  final Episode episode;

  EditorsPickData({required this.message, required this.episode});
}
