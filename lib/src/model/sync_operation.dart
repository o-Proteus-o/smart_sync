import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum SyncOperationType { create, update, delete }

class SyncOperation extends Equatable {
  final String id;
  final SyncOperationType type;
  final String collection;
  final dynamic data;
  final dynamic originalData;
  int retryCount;
  bool isCompleted;
  DateTime createdAt;
  DateTime? updatedAt;

  SyncOperation({
    String? id,
    required this.type,
    required this.collection,
    required this.data,
    this.originalData,
    this.retryCount = 0,
    this.isCompleted = false,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        super();

  @override
  List<Object?> get props => [
        id,
        type,
        collection,
        data,
        originalData,
        retryCount,
        isCompleted,
        createdAt,
        updatedAt,
      ];
}
