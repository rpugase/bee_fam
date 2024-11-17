import 'package:equatable/equatable.dart';

class RemoteSyncModel extends Equatable {

  final String remoteId;
  final bool isSynced;

  const RemoteSyncModel(this.remoteId, this.isSynced);

  @override
  List<Object?> get props => [remoteId];
}
