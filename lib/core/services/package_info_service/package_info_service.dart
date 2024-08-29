import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoServiceProvider =
    Provider<PackageInfo>((_) => throw UnimplementedError());

final packageInfoService = Provider<CairdioPackageInfo>((ref) {
  final packageInfo = CairdioPackageInfo(ref.watch(packageInfoServiceProvider));
  return packageInfo;
});

class CairdioPackageInfo {
  CairdioPackageInfo(this.packageInfo);

  final PackageInfo packageInfo;

  String get appName => packageInfo.appName;
  String get version => packageInfo.version;
  String get packageName => packageInfo.packageName;
  String get buildNumber => packageInfo.buildNumber;
}
