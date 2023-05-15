import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class StreamingCards extends StatelessWidget {
  final int movieId;

  const StreamingCards({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final streamProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: streamProvider.getMovieStreaming(movieId),
        builder: (_, AsyncSnapshot<List<Flatrate>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }

          final streaming = snapshot.data;

          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: streaming!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => _StreamingCard(
                streaming: streaming[index],
              ),
            ),
          );
        });
  }
}

class _StreamingCard extends StatelessWidget {
  final Flatrate streaming;

  const _StreamingCard({required this.streaming});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 75,
      height: 75,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(streaming.fullPathStreaming),
            height: 75,
            width: 75,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          streaming.providerName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
