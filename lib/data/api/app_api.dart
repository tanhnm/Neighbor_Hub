import 'package:dio/dio.dart';
import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:retrofit/retrofit.dart';



part 'app_api.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class AppApi {
  factory AppApi(Dio client, {
    String baseUrl,
  }) = _AppApi;

  @GET('/api/v1/driver/getDriverByPhoneNumber/{phoneNumber}')
  Future<DriverModel> getDriverByPhoneNumber(@Path() String phoneNumber);

  @PUT("/registrationForm/isActive")
  Future<HttpResponse<String>> activateDriver(
      @Body() Map<String, dynamic> requestBody,
      @Header("Authorization") String authorization,
      );

  // @GET('/getter/list-echos')
  // Future<List<EchoEntity>> getEchoes();
  //
  // @GET('/getter/echo/{id}')
  // Future<EchoEntity> getEchoById(@Path() String id);
  //
  // @GET('/getter/list-weapons')
  // Future<List<WeaponEntity>> getWeapons();
  //
  // @GET('/getter/weapon/{id}')
  // Future<WeaponEntity> getWeaponById(@Path() String id);
  //
  // @GET('/getter/character/{id}')
  // Future<CharacterEntity> getCharacterById(@Path() String id);
  //
  // @GET('/getter/list-items')
  // Future<List<ItemEntity>> getItems();
}