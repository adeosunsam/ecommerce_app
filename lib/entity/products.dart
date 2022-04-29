class Product {
  final String image, title, description, name;
  int price, quantity, total;
  final int id;

  Product({
    required this.image,
    required this.title,
    required this.quantity,
    required this.description,
    required this.total,
    required this.price,
    required this.id,
    required this.name,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: '2020 Apple iPad Air 10.9"',
    name: 'Apple iPad',
    quantity: 1,
    price: 579,
    total: 579,
    description:
        "Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, £4.99/month after free trial.",
    image: "assets/images/tablet.png",
  ),
  Product(
    id: 2,
    name: "Apple Watch",
    title: '',
    quantity: 1,
    price: 359,
    total: 359,
    description: dummyText,
    image: "assets/images/watch1.png",
  ),
  Product(
    id: 3,
    name: "Apple MacBook",
    title: '',
    quantity: 1,
    price: 234,
    total: 234,
    description: dummyText,
    image: "assets/images/macbook.png",
  ),
  Product(
    id: 4,
    name: "Apple iPhone",
    title: '',
    quantity: 1,
    price: 234,
    total: 234,
    description: dummyText,
    image: "assets/images/iphone.png",
  ),
  Product(
    id: 5,
    title: "APPLE AirPods Pro - White",
    name: 'APPLE AirPods',
    quantity: 1,
    price: 234,
    total: 234,
    description: dummyText,
    image: "assets/images/airpod.png",
  ),
  Product(
    id: 6,
    title: "",
    name: 'APPLE iMac',
    quantity: 1,
    price: 234,
    total: 234,
    description: dummyText,
    image: "assets/images/imac.png",
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
