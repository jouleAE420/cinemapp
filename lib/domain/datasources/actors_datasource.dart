import 'package:cinemapedia/domain/entities/actors.dart';

abstract class ActorsDataSource{
  
  Future<List<Actor>> getActorsByMovie(String movieId);
}