import 'package:cinemapedia/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.movie_outlined,
              color: colors.primary,
            ),
            const SizedBox(width: 5),
            Text(
              "CinemaPedia",
              style: titleStyle,
            ),
            const Spacer(), //Toma todo el espacio disponible
            IconButton(
                onPressed: () {
                  // final moviesRepository = ref.read(movieRepositoryProvider);
                  final searchMovies = ref.read(searchMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchMovieDelegate(
                        initialMovies: searchMovies,
                        searchMovies: ref
                            .read(searchMoviesProvider.notifier)
                            .searchedMoviesByQuery,
                      )).then((movie) {
                    // Solucion a Dont use Build Context Across Async Gaps
                    if (movie == null) return;
                    context.push("/home/0/movie/${movie.id}");
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
