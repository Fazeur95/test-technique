import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:searchimages/components/bloc/image_search_bloc.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ImageSearchBloc', () {
    final client = MockClient();
    final bloc = ImageSearchBloc(client);

    test('initial state is ImageSearchInitial', () {
      expect(bloc.state, equals(ImageSearchInitial()));
    });

    test('emits [ImageSearchLoadInProgress, ImageSearchLoadSuccess] when ImageSearchRequested is added', () {
      when(client.get(any)).thenAnswer((_) async => http.Response('{"hits": []}', 200));

      final expectedResponse = [
        ImageSearchLoadInProgress(),
        ImageSearchLoadSuccess([]),
      ];

      expectLater(
        bloc.stream,
        emitsInOrder(expectedResponse),
      );

      bloc.add(ImageSearchRequested('test'));
    });
  });
}
