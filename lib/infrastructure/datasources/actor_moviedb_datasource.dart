import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';

class ActorMovieDbDataSorce extends ActorsDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.theMovieKey,
        "languaje": "es-MX"
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get("/movie/$movieId/credits");
    if (response.statusCode != 200) {
      throw Exception("Movie with id: $movieId not found");
    }
    final castMovie = CastMovieDbResponse.fromJson(response.data);

    final List<Actor> cast =
        castMovie.cast.map((actor) => ActorMapper.castToEntity(actor)).toList();
        
    return cast;
  }
}
