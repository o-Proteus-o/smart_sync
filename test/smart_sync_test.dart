import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_sync/smart_sync.dart';
import 'package:smart_sync/src/adapters/local_adapter.dart';
import 'package:smart_sync/src/adapters/remote_adapter.dart';

// Generate mocks
@GenerateMocks([LocalAdapter, RemoteAdapter])
import 'smart_sync_test.mocks.dart';

void main() {
  late MockLocalAdapter mockLocalAdapter;
  late MockRemoteAdapter mockRemoteAdapter;
  late SmartSync smartSync;

  setUp(() {
    mockLocalAdapter = MockLocalAdapter();
    mockRemoteAdapter = MockRemoteAdapter();

    smartSync = SmartSync(
      localAdapter: mockLocalAdapter,
      remoteAdapter: mockRemoteAdapter,
    );
  });

  test('initialize calls both adapters', () async {
    when(mockLocalAdapter.initialize()).thenAnswer((_) async {});
    when(mockRemoteAdapter.initialize()).thenAnswer((_) async {});

    await smartSync.initialize();

    verify(mockLocalAdapter.initialize()).called(1);
    verify(mockRemoteAdapter.initialize()).called(1);
  });
}
