class CoffeeModel {
  String imagePath;
  String coffeName;
  double price;
  CoffeeModel({
    required this.imagePath,
    required this.coffeName,
    required this.price,
  });
}

final coffes = [
  CoffeeModel(
    imagePath: "assets/coffee/1.png",
    coffeName: "Caramel Macchiato",
    price: 2.50,
  ),
  CoffeeModel(
    imagePath: "assets/coffee/2.png",
    coffeName: "Caramel Cold Drink",
    price: 3.50,
  ),
  CoffeeModel(
    imagePath: "assets/coffee/3.png",
    coffeName: "Iced Coffe Mocha",
    price: 3.00,
  ),
  CoffeeModel(
    imagePath: "assets/coffee/4.png",
    coffeName: "Caramelized Pecan Latte",
    price: 4.50,
  ),
  CoffeeModel(
    imagePath: "assets/coffee/5.png",
    coffeName: "Toffee Nut Latte",
    price: 4.00,
  ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/6.png",
  //   coffeName: "Capuchino",
  //   price: 2.50,
  // ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/7.png",
  //   coffeName: "Toffee Nut Iced Latte",
  //   price: 3.50,
  // ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/8.png",
  //   coffeName: "Americano",
  //   price: 3.00,
  // ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/9.png",
  //   coffeName: "Vietnamese-Style Iced Coffee",
  //   price: 4.50,
  // ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/10.png",
  //   coffeName: "Black Tea Latte",
  //   price: 4.00,
  // ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/11.png",
  //   coffeName: "Classic Irish Coffee",
  //   price: 2.50,
  // ),
  // CoffeeModel(
  //   imagePath: "assets/coffee/12.png",
  //   coffeName: "Toffee Nut Crunch Latte",
  //   price: 3.50,
  // ),
];
