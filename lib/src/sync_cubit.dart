import 'package:bloc/bloc.dart';
import 'storage/local_storage.dart';
import 'network/network_monitor.dart';

abstract class SyncCubit<T> extends Cubit<T> {
  final LocalStorage<T> storage;
  final NetworkMonitor networkMonitor;

  SyncCubit(
    super.initialState, {
    required this.storage,
    required this.networkMonitor,
  }) {
    _initialize();
  }

  Future<void> _initialize() async {
    final cachedState = await storage.read();
    if (cachedState != null) {
      emit(cachedState);
    }
    networkMonitor.onReconnect(() async {
      await syncToServer(state);
    });
  }

  Future<void> syncToServer(T localState);

  @override
  void emit(T state) {
    super.emit(state);
    storage.save(state);
  }
}
