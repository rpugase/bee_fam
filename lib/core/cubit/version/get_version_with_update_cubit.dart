import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/utils/cache/dao/settings_dao.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GetVersionWithUpdateCubit extends BaseCubit<VersionState> implements ErrorHandler {

  final SettingsDao _settings;

  GetVersionWithUpdateCubit(this._settings) : super(VersionState());

  @override
  void onInit() async {
    final lastVersion = _settings.getLastVersion;
    final currentVersion = (await PackageInfo.fromPlatform()).version;
    final versionUpdated = currentVersion != lastVersion;

    emit(HandledVersionState(currentVersion, versionUpdated));

    if (versionUpdated) {
      await _settings.set(SettingsField.lastVersion, currentVersion);
    }
  }

  @override
  BlocError getErrorTemplate(Exception exception) {
    return VersionErrorState(exception, this);
  }

  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    return "";
  }
}

class VersionState extends BlocState {}

class HandledVersionState extends VersionState {
  final String version;
  final bool changed;

  HandledVersionState(this.version, this.changed);
}

class VersionErrorState extends BlocError {
  const VersionErrorState(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
