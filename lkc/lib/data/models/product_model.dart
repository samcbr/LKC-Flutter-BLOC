abstract class Product {
  //Base product model
  final int price;
  final String image;
  final String model;
  final String brand;
  final int id;
  final String color;
  const Product(
      {this.brand, this.id, this.image, this.model, this.price, this.color});
}

//Model for extension boards
class ExtensionBoard extends Product {
  String wireLength;
  ExtensionBoard({
    this.wireLength,
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory ExtensionBoard.fromMap(Map<String, dynamic> map) {
    return ExtensionBoard(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        wireLength: map['wireLength'],
        color: map['color']);
  }
}

class Mask extends Product {
  Mask({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Mask.fromMap(Map<String, dynamic> map) {
    return Mask(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class Sanitizer extends Product {
  Sanitizer({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Sanitizer.fromMap(Map<String, dynamic> map) {
    return Sanitizer(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class ImmunoBooster extends Product {
  ImmunoBooster({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory ImmunoBooster.fromMap(Map<String, dynamic> map) {
    return ImmunoBooster(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class Alarm extends Product {
  Alarm({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Alarm.fromMap(Map<String, dynamic> map) {
    return Alarm(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class Led extends Product {
  Led({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Led.fromMap(Map<String, dynamic> map) {
    return Led(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class MultiPlug extends Product {
  MultiPlug({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory MultiPlug.fromMap(Map<String, dynamic> map) {
    return MultiPlug(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class Cable extends Product {
  Cable({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Cable.fromMap(Map<String, dynamic> map) {
    return Cable(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class DoorBell extends Product {
  DoorBell({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory DoorBell.fromMap(Map<String, dynamic> map) {
    return DoorBell(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class Adapter extends Product {
  Adapter({int id, int price, String image, String model, String brand})
      : super(id: id, price: price, image: image, model: model, brand: brand);

  factory Adapter.fromMap(Map<String, dynamic> map) {
    return Adapter(
      id: map['id'],
      brand: map['brand'],
      image: map['image'],
      price: map['price'],
      model: map['model'],
    );
  }
}

class Stand extends Product {
  Stand({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Stand.fromMap(Map<String, dynamic> map) {
    return Stand(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class Battery extends Product {
  Battery({
    int id,
    int price,
    String image,
    String model,
    String brand,
    String color,
  }) : super(
            id: id,
            price: price,
            image: image,
            model: model,
            brand: brand,
            color: color);

  factory Battery.fromMap(Map<String, dynamic> map) {
    return Battery(
        id: map['id'],
        brand: map['brand'],
        image: map['image'],
        price: map['price'],
        model: map['model'],
        color: map['color']);
  }
}

class TopProduct {
  String image;
  String color;
  TopProduct({String image, String color}) {
    this.image = image;
    this.color = color;
  }
  factory TopProduct.fromMap(Map<String, dynamic> map) {
    return TopProduct(image: map['image'], color: map['color']);
  }
}
