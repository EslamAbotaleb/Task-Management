import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:task_mangement/core/util/constants.dart';
import 'package:task_mangement/modules/todos/data/datasource/remote/todo_remote_data_source.dart';
import 'package:task_mangement/modules/todos/data/models/todo_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late TodoRemoteDataSourceImplementation dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = TodoRemoteDataSourceImplementation(client: mockClient);

    // Register fallback value for Uri so mocktail can handle it
    registerFallbackValue(Uri.parse(BASE_URL));
  });

  group('TodoRemoteDataSource', () {
    test('should return a list of todos when the response code is 200', () async {
      // Arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(
            '{"todos": [{"id": 1, "todo": "Todo 1", "completed": false}]}', 200),
      );

      // Act
      final result = await dataSource.getTodosByPaginate(pageNumber: 3, limit: 10);

      // Assert
      expect(result, isA<List<TodoModel>>());
      expect(result.first.todo, 'Todo 1');
      verify(() => mockClient.get(any()));
    });

    test('should throw an exception when the response code is not 200', () async {
      // Arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response('Something went wrong', 500),
      );

      // Act
      final call = dataSource.getTodosByPaginate;

      // Assert
      expect(() => call(pageNumber: 0, limit: 10), throwsException);
    });
  });
}
