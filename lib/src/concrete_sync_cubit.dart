// concrete_sync_cubit.dart
import 'package:smart_sync/src/network/network_monitor.dart';
import 'package:smart_sync/src/storage/local_storage.dart';

import 'sync_cubit.dart';

class ConcreteSyncCubit extends SyncCubit<int> {
  ConcreteSyncCubit(
    int initialState, {
    required LocalStorage<int> storage,
    required NetworkMonitor networkMonitor,
  }) : super(initialState, storage: storage, networkMonitor: networkMonitor);

  // Implementing the syncToServer method
  @override
  Future<void> syncToServer(int localState) async {
    // Example implementation of syncing to the server
    print('Syncing to server with state: $localState');
  }
}

// concrete_sync_cubit_test.dart (This is just for the test context)
class TestSyncCubit extends SyncCubit<int> {
  TestSyncCubit(
    int initialState, {
    required LocalStorage<int> storage,
    required NetworkMonitor networkMonitor,
  }) : super(initialState, storage: storage, networkMonitor: networkMonitor);

  @override
  Future<void> syncToServer(int localState) async {
    // This can be a mock or simple implementation for testing
    print('Syncing to server with state: $localState');
  }
}
