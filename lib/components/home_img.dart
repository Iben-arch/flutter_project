class News {
  final String imageUrl;
  final String title;
  final String description;

  News(
      {required this.imageUrl, required this.title, required this.description});
}

final List<News> newsList = [
  News(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Image 1',
    description: 'Description of Image 1',
  ),
  News(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Image News 2',
    description: 'Description of Image 2',
  ),
  News(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Image 3',
    description: 'Description of Image 3',
  ),
];
