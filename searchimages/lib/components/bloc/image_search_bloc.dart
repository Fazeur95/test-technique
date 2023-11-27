import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/image_model.dart';

// Événements
abstract class ImageSearchEvent {}

class ImageSearchRequested extends ImageSearchEvent {
  final String query;
  ImageSearchRequested(this.query);
}

// États
abstract class ImageSearchState {}

class ImageSearchInitial extends ImageSearchState {}

class ImageSearchLoadInProgress extends ImageSearchState {}

class ImageSearchLoadSuccess extends ImageSearchState {
  final List<Image> images;
  ImageSearchLoadSuccess(this.images);
}

// Bloc
class ImageSearchBloc extends Bloc<ImageSearchEvent, ImageSearchState> {
  final http.Client httpClient;

  ImageSearchBloc(this.httpClient) : super(ImageSearchInitial()) {
    on<ImageSearchRequested>(_onImageSearchRequested);
  }

  void _onImageSearchRequested(
      ImageSearchRequested event, Emitter<ImageSearchState> emit) async {
    emit(ImageSearchLoadInProgress());

    try {
      final response = await httpClient.get(
        Uri.parse(
            'https://pixabay.com/api/?key=39895250-6ba3002ea49bd06791573051a&q=${event.query}&image_type=photo&pretty=true'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final images = (data['hits'] as List)
            .map((hit) => Image.fromJson(hit))
            .toList();

        emit(ImageSearchLoadSuccess(images));
      } else {
        throw Exception('Erreur de chargement des images');
      }
    } catch (_) {
      emit(ImageSearchInitial());
    }
  }
}
