import 'package:dio/dio.dart';
import 'package:flutter_app/model/postModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_app/model/userModel.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl: "https://randomuser.me/api/")
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET("/")
  Future<List<UserModel>> getUser();
}

@RestApi(baseUrl: "https://api.pexels.com/v1/")
abstract class PexelsApiService {
  factory PexelsApiService(Dio dio, {String baseUrl}) = _PexelsApiService;

  @GET("search")
  Future<PhotoResponse> getPhotos(
    @Query("query") String query,
    @Query("per_page") int perPage,
    @Query("page") int page,
  );
}

// Объединяем оба сервиса в один.
@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // User API сервис
  @GET("https://randomuser.me/api/")
  Future<List<UserModel>> getUser();

  // Pexels API сервис
  @GET("https://api.pexels.com/v1/search")
  Future<PhotoResponse> getPhotos(
    @Query("query") String query,
    @Query("per_page") int perPage,
    @Query("page") int page,
  );
}
