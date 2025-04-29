import 'dart:async';

class SyncEngine {
  final Duration syncInterval;
  final bool autoSync;
  Future<void> Function()? onSync;
  Timer? _syncTimer;

  SyncEngine({
    required this.syncInterval,
    required this.autoSync,
  });

  void start() {
    if (!autoSync) return;
    _syncTimer = Timer.periodic(syncInterval, (_) async {
      await onSync?.call();
    });
  }

  void stop() {
    _syncTimer?.cancel();
  }

  Future<void> manualSync() async {
    await onSync?.call();
  }
}