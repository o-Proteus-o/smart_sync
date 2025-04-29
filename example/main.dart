import 'package:flutter/material.dart';
import 'package:smart_sync/smart_sync.dart';
import 'package:smart_sync/src/adapters/hive_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final smartSync = SmartSync(
    localAdapter: HiveAdapter(),
    remoteAdapter: RestAdapter(baseUrl: 'https://api.example.com'),
  );

  await smartSync.initialize();

  runApp(MyApp(smartSync: smartSync));
}

class MyApp extends StatelessWidget {
  final SmartSync smartSync;

  const MyApp({super.key, required this.smartSync});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SmartSync Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await smartSync.localAdapter.create(
                    'todos',
                    {'id': '1', 'title': 'Buy milk', 'completed': false},
                  );
                },
                child: const Text('Add Todo Locally'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await smartSync.manualSync();
                },
                child: const Text('Manual Sync'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
