// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activityControllerHash() =>
    r'b65c7370c1eb282fe4aa61b7e4d13a34e238e062';

/// See also [ActivityController].
@ProviderFor(ActivityController)
final activityControllerProvider = AsyncNotifierProvider<ActivityController,
    List<BookingDetailModel>>.internal(
  ActivityController.new,
  name: r'activityControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activityControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActivityController = AsyncNotifier<List<BookingDetailModel>>;
String _$amountControllerHash() => r'ee1bd3eaf4f8ca4b51628c446db9490e71b33aa2';

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

abstract class _$AmountController
    extends BuildlessAutoDisposeAsyncNotifier<DealingModel> {
  late final int driverId;
  late final int bookingId;

  FutureOr<DealingModel> build(
    int driverId,
    int bookingId,
  );
}

/// See also [AmountController].
@ProviderFor(AmountController)
const amountControllerProvider = AmountControllerFamily();

/// See also [AmountController].
class AmountControllerFamily extends Family<AsyncValue<DealingModel>> {
  /// See also [AmountController].
  const AmountControllerFamily();

  /// See also [AmountController].
  AmountControllerProvider call(
    int driverId,
    int bookingId,
  ) {
    return AmountControllerProvider(
      driverId,
      bookingId,
    );
  }

  @override
  AmountControllerProvider getProviderOverride(
    covariant AmountControllerProvider provider,
  ) {
    return call(
      provider.driverId,
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
  String? get name => r'amountControllerProvider';
}

/// See also [AmountController].
class AmountControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AmountController, DealingModel> {
  /// See also [AmountController].
  AmountControllerProvider(
    int driverId,
    int bookingId,
  ) : this._internal(
          () => AmountController()
            ..driverId = driverId
            ..bookingId = bookingId,
          from: amountControllerProvider,
          name: r'amountControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$amountControllerHash,
          dependencies: AmountControllerFamily._dependencies,
          allTransitiveDependencies:
              AmountControllerFamily._allTransitiveDependencies,
          driverId: driverId,
          bookingId: bookingId,
        );

  AmountControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.driverId,
    required this.bookingId,
  }) : super.internal();

  final int driverId;
  final int bookingId;

  @override
  FutureOr<DealingModel> runNotifierBuild(
    covariant AmountController notifier,
  ) {
    return notifier.build(
      driverId,
      bookingId,
    );
  }

  @override
  Override overrideWith(AmountController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AmountControllerProvider._internal(
        () => create()
          ..driverId = driverId
          ..bookingId = bookingId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        driverId: driverId,
        bookingId: bookingId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AmountController, DealingModel>
      createElement() {
    return _AmountControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AmountControllerProvider &&
        other.driverId == driverId &&
        other.bookingId == bookingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, driverId.hashCode);
    hash = _SystemHash.combine(hash, bookingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AmountControllerRef on AutoDisposeAsyncNotifierProviderRef<DealingModel> {
  /// The parameter `driverId` of this provider.
  int get driverId;

  /// The parameter `bookingId` of this provider.
  int get bookingId;
}

class _AmountControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AmountController,
        DealingModel> with AmountControllerRef {
  _AmountControllerProviderElement(super.provider);

  @override
  int get driverId => (origin as AmountControllerProvider).driverId;
  @override
  int get bookingId => (origin as AmountControllerProvider).bookingId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
