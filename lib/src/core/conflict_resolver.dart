abstract class ConflictResolver {
  const ConflictResolver();

  factory ConflictResolver.serverWins() = ServerWinsConflictResolver;
  factory ConflictResolver.clientWins() = ClientWinsConflictResolver;
  factory ConflictResolver.custom(
    Future<dynamic> Function({
      required dynamic localData,
      required dynamic remoteData,
    })
    resolver,
  ) = CustomConflictResolver;

  Future<dynamic> resolve({
    required dynamic localData,
    required dynamic remoteData,
  });
}

class ServerWinsConflictResolver extends ConflictResolver {
  const ServerWinsConflictResolver();

  @override
  Future<dynamic> resolve({
    required dynamic localData,
    required dynamic remoteData,
  }) async => remoteData;
}

class ClientWinsConflictResolver extends ConflictResolver {
  const ClientWinsConflictResolver();

  @override
  Future<dynamic> resolve({
    required dynamic localData,
    required dynamic remoteData,
  }) async => localData;
}

class CustomConflictResolver extends ConflictResolver {
  final Future<dynamic> Function({
    required dynamic localData,
    required dynamic remoteData,
  })
  _resolver;

  const CustomConflictResolver(this._resolver);

  @override
  Future<dynamic> resolve({
    required dynamic localData,
    required dynamic remoteData,
  }) => _resolver(localData: localData, remoteData: remoteData);
}
