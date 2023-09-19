import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:custom_flutter/check/animation_slide/models/movie.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AnimationSlide extends StatefulWidget {
  const AnimationSlide({super.key});

  @override
  State<AnimationSlide> createState() => _AnimationSlideState();
}

class _AnimationSlideState extends State<AnimationSlide>
    with SingleTickerProviderStateMixin {
  late List<Movie> data = [];
  int currentIndex = 2;

  final _animatedListKey = GlobalKey<AnimatedListState>();
  final PageController _pageController = PageController();
  double _page = 0.0;
  void listenScroll() {
    setState(() {
      _page = _pageController.page!;
    });
  }

  @override
  void initState() {
    getVideo();
    _pageController.addListener(listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  void getVideo() async {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'language': 'en-US'},
      headers: {
        "accept": 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MzdhOGYzNmUyNjhiODZlM2YyMGE1N2Y2NmNjYmY3OCIsInN1YiI6IjY0ZjU1MDNhOTdhNGU2MjU5ZGM0YjQ0ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JL8MZq53VMZzF7S3xrJqqlZf3Pf0O-AqvH5HoAFMqbM',
      },
    ));

    final res = await dio.get(
      '/movie/popular',
      queryParameters: {'page': 1},
    );
    final List listMovie = res.data['results'];
    final List<Movie> movies = listMovie
        .map((e) => Movie(
              adult: e["adult"],
              backdropPath: e["backdrop_path"] != '' ||
                      e["backdrop_path"] != null
                  ? 'https://image.tmdb.org/t/p/w500${e['backdrop_path']}'
                  : "https://www.reelviews.net/resources/img/default_poster.jpg",
              genreIds:
                  List<String>.from(e["genre_ids"].map((x) => x.toString())),
              id: e["id"],
              originalLanguage: e["original_language"],
              originalTitle: e["original_title"],
              overview: e["overview"],
              popularity: e["popularity"],
              posterPath: e["poster_path"] != '' || e["poster_path"] != null
                  ? 'https://image.tmdb.org/t/p/w500${e['poster_path']}'
                  : "https://www.reelviews.net/resources/img/default_poster.jpg",
              releaseDate: DateTime.now(),
              title: e["title"],
              video: e["video"],
              voteAverage: 0.0,
              voteCount: e["vote_count"],
            ))
        .toList();

    setState(() {
      data = movies;
      // data = movies.sublist(0, 4);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: null,
            child: Container(
              height: size.height * 0.7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data[currentIndex].posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: null,
            child: Container(
              height: size.height * 0.7,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Color.fromARGB(151, 0, 0, 0),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1, 0.4, 0.6],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: size.height / 2 + 100,
            bottom: null,
            child: SizedBox(
              height: 150,
              child: AnimatedList(
                key: _animatedListKey,
                physics: const PageScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                initialItemCount: data.length,
                itemBuilder: (context, index, animation) {
                  final item = data[index];
                  final percent = _page - _page.floor();
                  final factor = percent > 0.5 ? (1 - percent) : percent;

                  return GestureDetector(
                    onTap: () {
                      data.add(item);
                      _animatedListKey.currentState
                          ?.insertItem(data.length - 1);

                      final root = item;

                      data.removeAt(index);

                      _animatedListKey.currentState?.removeItem(
                        index,
                        (context, animation) => FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            child: _Item(item: root),
                          ),
                        ),
                      );

                      setState(() {
                        currentIndex = data.length - 1;
                      });
                    },
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(vector.radians(90 * factor)),
                      child: _Item(item: item),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.item});
  final Movie item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(item.posterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
// https://www.youtube.com/watch?v=HyVUhtiYlVs