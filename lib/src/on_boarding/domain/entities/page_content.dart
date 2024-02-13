import 'package:educa_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  factory PageContent.first() {
    return const PageContent(
      image: MediaRes.casualReading,
      title: 'Brand new curriculum',
      description:
          'This is the first online education platform designed by the '
          "world's top professors",
    );
  }

  factory PageContent.second() {
    return const PageContent(
      image: MediaRes.casualLife,
      title: 'Brand a fun atmosphere',
      description:
          'Explore a vibrant and engaging atmosphere that turns education into '
          'a delightful adventure',
    );
  }

  factory PageContent.third() {
    return const PageContent(
      image: MediaRes.casualMeditationScience,
      title: 'Easy to join the lesson',
      description:
          'Effortless learning with top professors, ensuring easy access to '
          'enriching lessons for everyone',
    );
  }

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
