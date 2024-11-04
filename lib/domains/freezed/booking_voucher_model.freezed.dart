// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_voucher_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingVoucherElementModel _$BookingVoucherElementModelFromJson(
    Map<String, dynamic> json) {
  return _BookingVoucherElementModel.fromJson(json);
}

/// @nodoc
mixin _$BookingVoucherElementModel {
  int get id => throw _privateConstructorUsedError;
  String? get booking => throw _privateConstructorUsedError;
  String get voucher => throw _privateConstructorUsedError;
  bool get used => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this BookingVoucherElementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingVoucherElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingVoucherElementModelCopyWith<BookingVoucherElementModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingVoucherElementModelCopyWith<$Res> {
  factory $BookingVoucherElementModelCopyWith(BookingVoucherElementModel value,
          $Res Function(BookingVoucherElementModel) then) =
      _$BookingVoucherElementModelCopyWithImpl<$Res,
          BookingVoucherElementModel>;
  @useResult
  $Res call(
      {int id, String? booking, String voucher, bool used, UserModel? user});

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$BookingVoucherElementModelCopyWithImpl<$Res,
        $Val extends BookingVoucherElementModel>
    implements $BookingVoucherElementModelCopyWith<$Res> {
  _$BookingVoucherElementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingVoucherElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? booking = freezed,
    Object? voucher = null,
    Object? used = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      booking: freezed == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as String?,
      voucher: null == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as String,
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  /// Create a copy of BookingVoucherElementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingVoucherElementModelImplCopyWith<$Res>
    implements $BookingVoucherElementModelCopyWith<$Res> {
  factory _$$BookingVoucherElementModelImplCopyWith(
          _$BookingVoucherElementModelImpl value,
          $Res Function(_$BookingVoucherElementModelImpl) then) =
      __$$BookingVoucherElementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String? booking, String voucher, bool used, UserModel? user});

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$BookingVoucherElementModelImplCopyWithImpl<$Res>
    extends _$BookingVoucherElementModelCopyWithImpl<$Res,
        _$BookingVoucherElementModelImpl>
    implements _$$BookingVoucherElementModelImplCopyWith<$Res> {
  __$$BookingVoucherElementModelImplCopyWithImpl(
      _$BookingVoucherElementModelImpl _value,
      $Res Function(_$BookingVoucherElementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingVoucherElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? booking = freezed,
    Object? voucher = null,
    Object? used = null,
    Object? user = freezed,
  }) {
    return _then(_$BookingVoucherElementModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      booking: freezed == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as String?,
      voucher: null == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as String,
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingVoucherElementModelImpl implements _BookingVoucherElementModel {
  const _$BookingVoucherElementModelImpl(
      {required this.id,
      this.booking,
      required this.voucher,
      required this.used,
      this.user});

  factory _$BookingVoucherElementModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BookingVoucherElementModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? booking;
  @override
  final String voucher;
  @override
  final bool used;
  @override
  final UserModel? user;

  @override
  String toString() {
    return 'BookingVoucherElementModel(id: $id, booking: $booking, voucher: $voucher, used: $used, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingVoucherElementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.booking, booking) || other.booking == booking) &&
            (identical(other.voucher, voucher) || other.voucher == voucher) &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, booking, voucher, used, user);

  /// Create a copy of BookingVoucherElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingVoucherElementModelImplCopyWith<_$BookingVoucherElementModelImpl>
      get copyWith => __$$BookingVoucherElementModelImplCopyWithImpl<
          _$BookingVoucherElementModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingVoucherElementModelImplToJson(
      this,
    );
  }
}

abstract class _BookingVoucherElementModel
    implements BookingVoucherElementModel {
  const factory _BookingVoucherElementModel(
      {required final int id,
      final String? booking,
      required final String voucher,
      required final bool used,
      final UserModel? user}) = _$BookingVoucherElementModelImpl;

  factory _BookingVoucherElementModel.fromJson(Map<String, dynamic> json) =
      _$BookingVoucherElementModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get booking;
  @override
  String get voucher;
  @override
  bool get used;
  @override
  UserModel? get user;

  /// Create a copy of BookingVoucherElementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingVoucherElementModelImplCopyWith<_$BookingVoucherElementModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VoucherModel _$VoucherModelFromJson(Map<String, dynamic> json) {
  return _VoucherModel.fromJson(json);
}

/// @nodoc
mixin _$VoucherModel {
  int get voucherId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  List<String> get bookings => throw _privateConstructorUsedError;
  List<BookingVoucherElementModel> get userVouchers =>
      throw _privateConstructorUsedError;
  List<BookingVoucherElementModel> get bookingVouchers =>
      throw _privateConstructorUsedError;

  /// Serializes this VoucherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherModelCopyWith<VoucherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherModelCopyWith<$Res> {
  factory $VoucherModelCopyWith(
          VoucherModel value, $Res Function(VoucherModel) then) =
      _$VoucherModelCopyWithImpl<$Res, VoucherModel>;
  @useResult
  $Res call(
      {int voucherId,
      String code,
      String description,
      int discount,
      String expiryDate,
      bool status,
      List<String> bookings,
      List<BookingVoucherElementModel> userVouchers,
      List<BookingVoucherElementModel> bookingVouchers});
}

/// @nodoc
class _$VoucherModelCopyWithImpl<$Res, $Val extends VoucherModel>
    implements $VoucherModelCopyWith<$Res> {
  _$VoucherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voucherId = null,
    Object? code = null,
    Object? description = null,
    Object? discount = null,
    Object? expiryDate = null,
    Object? status = null,
    Object? bookings = null,
    Object? userVouchers = null,
    Object? bookingVouchers = null,
  }) {
    return _then(_value.copyWith(
      voucherId: null == voucherId
          ? _value.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      bookings: null == bookings
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userVouchers: null == userVouchers
          ? _value.userVouchers
          : userVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElementModel>,
      bookingVouchers: null == bookingVouchers
          ? _value.bookingVouchers
          : bookingVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElementModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherModelImplCopyWith<$Res>
    implements $VoucherModelCopyWith<$Res> {
  factory _$$VoucherModelImplCopyWith(
          _$VoucherModelImpl value, $Res Function(_$VoucherModelImpl) then) =
      __$$VoucherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int voucherId,
      String code,
      String description,
      int discount,
      String expiryDate,
      bool status,
      List<String> bookings,
      List<BookingVoucherElementModel> userVouchers,
      List<BookingVoucherElementModel> bookingVouchers});
}

/// @nodoc
class __$$VoucherModelImplCopyWithImpl<$Res>
    extends _$VoucherModelCopyWithImpl<$Res, _$VoucherModelImpl>
    implements _$$VoucherModelImplCopyWith<$Res> {
  __$$VoucherModelImplCopyWithImpl(
      _$VoucherModelImpl _value, $Res Function(_$VoucherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voucherId = null,
    Object? code = null,
    Object? description = null,
    Object? discount = null,
    Object? expiryDate = null,
    Object? status = null,
    Object? bookings = null,
    Object? userVouchers = null,
    Object? bookingVouchers = null,
  }) {
    return _then(_$VoucherModelImpl(
      voucherId: null == voucherId
          ? _value.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      bookings: null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userVouchers: null == userVouchers
          ? _value._userVouchers
          : userVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElementModel>,
      bookingVouchers: null == bookingVouchers
          ? _value._bookingVouchers
          : bookingVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElementModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherModelImpl implements _VoucherModel {
  const _$VoucherModelImpl(
      {required this.voucherId,
      required this.code,
      required this.description,
      required this.discount,
      required this.expiryDate,
      required this.status,
      required final List<String> bookings,
      required final List<BookingVoucherElementModel> userVouchers,
      required final List<BookingVoucherElementModel> bookingVouchers})
      : _bookings = bookings,
        _userVouchers = userVouchers,
        _bookingVouchers = bookingVouchers;

  factory _$VoucherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherModelImplFromJson(json);

  @override
  final int voucherId;
  @override
  final String code;
  @override
  final String description;
  @override
  final int discount;
  @override
  final String expiryDate;
  @override
  final bool status;
  final List<String> _bookings;
  @override
  List<String> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  final List<BookingVoucherElementModel> _userVouchers;
  @override
  List<BookingVoucherElementModel> get userVouchers {
    if (_userVouchers is EqualUnmodifiableListView) return _userVouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userVouchers);
  }

  final List<BookingVoucherElementModel> _bookingVouchers;
  @override
  List<BookingVoucherElementModel> get bookingVouchers {
    if (_bookingVouchers is EqualUnmodifiableListView) return _bookingVouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookingVouchers);
  }

  @override
  String toString() {
    return 'VoucherModel(voucherId: $voucherId, code: $code, description: $description, discount: $discount, expiryDate: $expiryDate, status: $status, bookings: $bookings, userVouchers: $userVouchers, bookingVouchers: $bookingVouchers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherModelImpl &&
            (identical(other.voucherId, voucherId) ||
                other.voucherId == voucherId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings) &&
            const DeepCollectionEquality()
                .equals(other._userVouchers, _userVouchers) &&
            const DeepCollectionEquality()
                .equals(other._bookingVouchers, _bookingVouchers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      voucherId,
      code,
      description,
      discount,
      expiryDate,
      status,
      const DeepCollectionEquality().hash(_bookings),
      const DeepCollectionEquality().hash(_userVouchers),
      const DeepCollectionEquality().hash(_bookingVouchers));

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherModelImplCopyWith<_$VoucherModelImpl> get copyWith =>
      __$$VoucherModelImplCopyWithImpl<_$VoucherModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherModelImplToJson(
      this,
    );
  }
}

abstract class _VoucherModel implements VoucherModel {
  const factory _VoucherModel(
          {required final int voucherId,
          required final String code,
          required final String description,
          required final int discount,
          required final String expiryDate,
          required final bool status,
          required final List<String> bookings,
          required final List<BookingVoucherElementModel> userVouchers,
          required final List<BookingVoucherElementModel> bookingVouchers}) =
      _$VoucherModelImpl;

  factory _VoucherModel.fromJson(Map<String, dynamic> json) =
      _$VoucherModelImpl.fromJson;

  @override
  int get voucherId;
  @override
  String get code;
  @override
  String get description;
  @override
  int get discount;
  @override
  String get expiryDate;
  @override
  bool get status;
  @override
  List<String> get bookings;
  @override
  List<BookingVoucherElementModel> get userVouchers;
  @override
  List<BookingVoucherElementModel> get bookingVouchers;

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherModelImplCopyWith<_$VoucherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
