import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sync/src/concrete_sync_cubit.dart';
import 'package:smart_sync/src/network/network_monitor.dart';
import 'package:smart_sync/src/storage/hive_storage.dart';
import 'package:smart_sync/src/sync_cubit.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ConcreteSyncCubit(
          0,  // Initial state
          storage: HiveStorage<int>(boxName: 'counterBox', key: 'counter'),
          networkMonitor: NetworkMonitor(),  // Assuming it's implemented elsewhere
        ),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sync Counter')),
      body: Center(
        child: BlocBuilder<SyncCubit<int>, int>(
          builder: (context, state) {
            return Text('Count: $state');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use the SyncCubit (ConcreteSyncCubit here)
          context.read<SyncCubit<int>>().emit(context.read<SyncCubit<int>>().state + 1);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
