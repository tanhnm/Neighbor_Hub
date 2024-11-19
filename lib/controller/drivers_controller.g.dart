// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drivers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$driversControllerHash() => r'2123baaa71ba693f9e1639dc9ff80a01a4bc33de';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DriversController
    extends BuildlessAutoDisposeAsyncNotifier<List<RegistrationFormModel>> {
  late final int bookingId;

  FutureOr<List<RegistrationFormModel>> build(
    int bookingId,
  );
}

/// See also [DriversController].
@ProviderFor(DriversController)
const driversControllerProvider = DriversControllerFamily();

/// See also [DriversController].
class DriversControllerFamily
    extends Family<AsyncValue<List<RegistrationFormModel>>> {
  /// See also [DriversController].
  const DriversControllerFamily();

  /// See also [DriversController].
  DriversControllerProvider call(
    int bookingId,
  ) {
    return DriversControllerProvider(
      bookingId,
    );
  }

  @override
  DriversControllerProvider getProviderOverride(
    covariant DriversControllerProvider provider,
  ) {
    return call(
      provider.bookingId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'driversControllerProvider';
}

/// See also [DriversController].
class DriversControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DriversController, List<RegistrationFormModel>> {
  /// See also [DriversController].
  DriversControllerProvider(
    int bookingId,
  ) : this._internal(
          () => DriversController()..bookingId = bookingId,
          from: driversControllerProvider,
          name: r'driversControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$driversControllerHash,
          dependencies: DriversControllerFamily._dependencies,
          allTransitiveDependencies:
              DriversControllerFamily._allTransitiveDependencies,
          bookingId: bookingId,
        );

  DriversControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookingId,
  }) : super.internal();

  final int bookingId;

  @override
  FutureOr<List<RegistrationFormModel>> runNotifierBuild(
    covariant DriversController notifier,
  ) {
    return notifier.build(
      bookingId,
    );
  }

  @override
  Override overrideWith(DriversController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DriversControllerProvider._internal(
        () => create()..bookingId = bookingId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookingId: bookingId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DriversController,
      List<RegistrationFormModel>> createElement() {
    return _DriversControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DriversControllerProvider && other.bookingId == bookingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DriversControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<RegistrationFormModel>> {
  /// The parameter `bookingId` of this provider.
  int get bookingId;
}

class _DriversControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DriversController,
        List<RegistrationFormModel>> with DriversControllerRef {
  _DriversControllerProviderElement(super.provider);

  @override
  int get bookingId => (origin as DriversControllerProvider).bookingId;
}

String _$bookingDriverControllerHash() =>
    r'4724150dcf2c2cbe18a606f65c3fc81d2516688c';

/// See also [BookingDriverController].
@ProviderFor(BookingDriverController)
final bookingDriverControllerProvider = AsyncNotifierProvider<
    BookingDriverController, List<BookingDetailModel>>.internal(
  BookingDriverController.new,
  name: r'bookingDriverControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingDriverControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookingDriverController = AsyncNotifier<List<BookingDetailModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
