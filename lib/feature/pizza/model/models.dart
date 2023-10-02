import 'dart:math';
import 'package:flutter/material.dart';

double randomNumber() {
  var random = Random();
  double min = -1.0;
  int max = 1;
  double result = min + random.nextDouble() * (max - min);
  return result * 0.8.toDouble();
}

const String dish = 'assets/pizza/dish.png';

class PizzaModel {
  final String image, name, desc;
  final List<double> price;

  PizzaModel({
    required this.desc,
    required this.image,
    required this.name,
    required this.price,
  });
}

List<PizzaModel> dataPizza = [
  PizzaModel(
    image: 'assets/pizza/pizza-0.png',
    name: 'Tomato & Cheese Pizza',
    price: [1, 2, 3],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-1.png',
    name: 'Tomato & Cheese Pizza',
    price: [4, 5, 6],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-2.png',
    name: 'Tomato & Cheese Pizza',
    price: [7, 8, 9],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-3.png',
    name: 'Tomato & Cheese Pizza',
    price: [10, 11, 12],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-4.png',
    name: 'Tomato & Cheese Pizza',
    price: [1.5, 2.5, 3.5],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-5.png',
    name: 'Tomato & Cheese Pizza',
    price: [2.5, 3.5, 4.5],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-6.png',
    name: 'Tomato & Cheese Pizza',
    price: [5.5, 6.6, 7.7],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-7.png',
    name: 'Tomato & Cheese Pizza',
    price: [8.8, 9.9, 10.10],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-8.png',
    name: 'Tomato & Cheese Pizza',
    price: [112, 211, 333],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
  PizzaModel(
    image: 'assets/pizza/pizza-9.png',
    name: 'Tomato & Cheese Pizza',
    price: [1.1, 2.1, 3.1],
    desc: 'crust topped with our homemade pizza sauce and cheese',
  ),
];

class Topping {
  final String onList, onPizza;
  final List<Offset> offset;

  Topping({required this.onList, required this.offset, required this.onPizza});

  bool compare(Topping newTopping) => newTopping.onList == onList;
}

List<Topping> toppings = [
  Topping(
    onList: 'assets/pizza/chili.png',
    onPizza: 'assets/pizza/chili_unit.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
  Topping(
    onList: 'assets/pizza/mushroom.png',
    onPizza: 'assets/pizza/mushroom_unit.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
  Topping(
    onList: 'assets/pizza/olive.png',
    onPizza: 'assets/pizza/olive_unit.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
  Topping(
    onList: 'assets/pizza/onion.png',
    onPizza: 'assets/pizza/onion.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
  Topping(
    onList: 'assets/pizza/pea.png',
    onPizza: 'assets/pizza/pea_unit.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
  Topping(
    onList: 'assets/pizza/pickle.png',
    onPizza: 'assets/pizza/pickle_unit.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
  Topping(
    onList: 'assets/pizza/potato.png',
    onPizza: 'assets/pizza/potato_unit.png',
    offset: [
      for (var i = 0; i < 5; i++) Offset(randomNumber(), randomNumber()),
    ],
  ),
];

class BoxPizza {
  final String image;

  BoxPizza({required this.image});
}

final List<BoxPizza> boxPizzas = [
  BoxPizza(image: 'assets/pizza/box_diegoveloper.png'),
  BoxPizza(image: 'assets/pizza/box_front.png'),
  BoxPizza(image: 'assets/pizza/box_inside.png'),
];
