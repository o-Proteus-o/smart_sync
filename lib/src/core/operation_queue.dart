import 'package:smart_sync/src/model/sync_operation.dart';

class OperationQueue {
  final List<SyncOperation> _operations = [];

  Future<void> addOperation(SyncOperation operation) async {
    _operations.add(operation);
  }

  Future<List<SyncOperation>> getPendingOperations() async {
    return _operations.where((op) => !op.isCompleted).toList();
  }

  Future<void> markOperationComplete(String operationId) async {
    final operation = _operations.firstWhere((op) => op.id == operationId);
    operation.isCompleted = true;
  }

  Future<void> retryOperation(String operationId) async {
    final operation = _operations.firstWhere((op) => op.id == operationId);
    operation.retryCount++;
  }
}
