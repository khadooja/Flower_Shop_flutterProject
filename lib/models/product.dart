class Product {
  final int id;
  final String name;
  final String price;
  final String image;
  bool isFavourite;
  final String title;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.isFavourite = false,
    required this.description,
    required this.title,
  });

  get rating => null;
  //get description => null;
  //get title => null;
}

List<Product> demoProducts = [
  Product(
      id: 1,
      name: "Rose",
      price: "20",
      image: "images/1.jpg",
      description:
          'Known for its classic beauty and fragrance, roses are symbols of love and passion. They come in many colors, each with its own meaning.',
      title: 'Known for its classic beauty and fragrance'),
  Product(
      id: 2,
      name: "Tulip",
      price: "30",
      image: "images/7.jpg",
      description:
          'Tulips are vibrant and come in almost every color. They are often associated with spring and symbolize perfect love.',
      title: 'Tulips are vibrant and almost every color'),
  Product(
      id: 3,
      name: "Lily",
      price: "25",
      image: "images/3.jpg",
      description:
          'Lilies are elegant flowers with a strong fragrance. They are often found in white and symbolize purity and refined beauty.',
      title: 'Lilies are elegant flowers with a strong fragrance'),
  Product(
      id: 4,
      name: "Orchid",
      price: "20",
      image: "images/4.jpg",
      description:
          'Sunflowers are bright and cheerful, always facing the sun. They symbolize adoration, loyalty, and longevity.',
      title: 'Sunflowers are bright and cheerful'),
  Product(
      id: 5,
      name: "Sunflower",
      price: "25",
      image: "images/5.jpg",
      description:
          'Sunflowers are bright and cheerful, always facing the sun. They symbolize adoration, loyalty, and longevity.',
      title: 'Sunflowers are bright and cheerful'),
  Product(
      id: 6,
      name: "Daisy",
      price: "25",
      image: "images/6.jpg",
      description:
          'Daisies are simple and charming, usually white with a yellow center. They represent innocence and purity.',
      title: 'Daisies are simple and charming'),
  Product(
      id: 7,
      name: "Hydrangea",
      price: "35",
      image: "images/5.jpg",
      description:
          'Hydrangeas have large, lush blooms in various colors. They symbolize heartfelt emotions and gratitude.',
      title: 'Hydrangeas have large.'),
  Product(
      id: 8,
      name: "Peony",
      price: "22",
      image: "images/6.jpg",
      description:
          'Peonies are lush and fragrant, often used in weddings. They represent romance, prosperity, and good fortune.',
      title: 'Peonies are lush and fragran'),
  Product(
      id: 9,
      name: "Rose",
      price: "20",
      image: "images/1.jpg",
      description:
          'Known for its classic beauty and fragrance, roses are symbols of love and passion. They come in many colors, each with its own meaning.',
      title: 'Known for its classic beauty and fragrance'),
  Product(
      id: 10,
      name: "Tulip",
      price: "30",
      image: "images/7.jpg",
      description:
          'Tulips are vibrant and come in almost every color. They are often associated with spring and symbolize perfect love.',
      title: 'Tulips are vibrant and come in almost every color'),
];
