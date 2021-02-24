// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api.dart';
import '../system/app_database.dart';
import '../services/customer_service.dart';
import '../services/dynamic_link_service.dart';
import '../services/encryption_service.dart';
import '../services/media_service.dart';
import '../services/permissions_service.dart';
import '../services/shared_preferences_service.dart';
import '../services/third_party_services_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<Api>(() => Api());
  gh.lazySingleton<AppDatabase>(() => AppDatabase());
  gh.lazySingleton<BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.lazySingleton<CustomerService>(() => CustomerService());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<DynamicLinkService>(() => DynamicLinkService());
  gh.lazySingleton<EncryptionService>(() => EncryptionService());
  gh.lazySingleton<MediaService>(() => MediaService());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<PermissionsService>(() => PermissionsService());
  gh.lazySingleton<SharedPreferencesService>(() => SharedPreferencesService());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  BottomSheetService get bottomSheetService => BottomSheetService();
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
