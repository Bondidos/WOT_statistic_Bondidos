import 'dart:io';
import 'dart:isolate';

import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database/database.dart';

Database constructDb() {
  Future<DriftIsolate> _createDriftIsolate() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'db.sqlite');
    final receivePort = ReceivePort();

    await Isolate.spawn(
      _startBackground,
      _IsolateStartRequest(receivePort.sendPort, path),
    );

    return await receivePort.first as DriftIsolate;
  }

  DatabaseConnection _createDriftIsolateAndConnect() {
    return DatabaseConnection.delayed(() async {
      final isolate = await _createDriftIsolate();
      return await isolate.connect();
    }());
  }

  return Database.connect(_createDriftIsolateAndConnect());
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}
