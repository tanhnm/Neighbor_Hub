import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_state_model.freezed.dart';

@freezed
class DriverState with _$DriverState {
  const factory DriverState({
    required List<Map<String, dynamic>> drivers,
    required List<dynamic> registrationDrivers,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _DriverState;

  // Initial empty state for when nothing is fetched yet
  factory DriverState.initial() => const DriverState(
    drivers: [],
    registrationDrivers: [],
    errorMessage: null,
    isLoading: false,
  );
}
