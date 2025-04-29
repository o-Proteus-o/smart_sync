import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_sync/src/adapters/local_adapter.dart';
import 'package:smart_sync/src/adapters/remote_adapter.dart';
import 'package:smart_sync/src/core/conflict_resolver.dart';
import 'package:smart_sync/src/core/operation_queue.dart';
import 'package:smart_sync/src/core/sync_engine.dart';
import 'package:smart_sync/src/model/sync_operation.dart';

class SmartSync {
  final LocalAdapter localAdapter;
  final RemoteAdapter remoteAdapter;
  final ConflictResolver conflictResolver;
  final SyncEngine _syncEngine;
  final OperationQueue _operationQueue;

  SmartSync({
    required this.localAdapter,
    required this.remoteAdapter,
    ConflictResolver? conflictResolver,
    Duration syncInterval = const Duration(seconds: 30),
    bool autoSync = true,
  })  : conflictResolver = conflictResolver ?? ConflictResolver.serverWins(),
        _operationQueue = OperationQueue(),
        _syncEngine = SyncEngine(
          syncInterval: syncInterval,
          autoSync: autoSync,
        ) {
    _syncEngine.onSync = _performSync;
  }

  Future<void> initialize() async {
    await localAdapter.initialize();
    await remoteAdapter.initialize();
    _syncEngine.start();
  }

  /// Manually triggers synchronization between local and remote adapters
  Future<void> manualSync() async {
    await _performSync();
  }

  Future<void> _performSync() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return;

    final pendingOperations = await _operationQueue.getPendingOperations();

    for (final operation in pendingOperations) {
      try {
        await _executeOperation(operation);
        await _operationQueue.markOperationComplete(operation.id);
      } catch (e) {
        await _operationQueue.retryOperation(operation.id);
      }
    }
  }

  Future<void> _executeOperation(SyncOperation operation) async {
    switch (operation.type) {
      case SyncOperationType.create:
        // Implementation
        break;
      case SyncOperationType.update:
        // Implementation
        break;
      case SyncOperationType.delete:
        // Implementation
        break;
    }
  }

  Future<void> dispose() async {
    _syncEngine.stop();
  }
}
