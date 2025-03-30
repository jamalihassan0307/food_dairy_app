// ignore_for_file: file_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String calories;
  final String protein;
  final String prepTime;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.calories,
    required this.protein,
    required this.prepTime,
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? calories,
    String? protein,
    String? prepTime,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      prepTime: prepTime ?? this.prepTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'calories': calories,
      'protein': protein,
      'prepTime': prepTime,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      calories: map['calories'] as String,
      protein: map['protein'] as String,
      prepTime: map['prepTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, description: $description, imageUrl: $imageUrl, calories: $calories, protein: $protein, prepTime: $prepTime)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.calories == calories &&
        other.protein == protein &&
        other.prepTime == prepTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        calories.hashCode ^
        protein.hashCode ^
        prepTime.hashCode;
  }
}

List<Recipe> makeRecipes = [
  Recipe(
      id: "1",
      name: "Spaghetti Bolognese",
      description: "A classic Italian meat sauce served over pasta",
      imageUrl: "assets/images/spaghetti.png",
      calories: "650",
      protein: "35",
      prepTime: "60"),
  Recipe(
    id: "2",
    name: "Chicken Parmesan",
    description:
        "Breaded chicken breast topped with tomato sauce and mozzarella",
    imageUrl: "assets/images/chicken.png",
    calories: "550",
    protein: "45",
    prepTime: "30",
  ),
  Recipe(
    id: "3",
    name: "Caesar Salad",
    description:
        "Romaine lettuce with creamy Caesar dressing, croutons and parmesan",
    imageUrl: "assets/images/salad.png",
    calories: "250",
    protein: "10",
    prepTime: "10",
  ),
  Recipe(
    id: "4",
    name: "Tacos",
    description:
        "Soft tortilla shells filled with seasoned ground beef, lettuce, cheese and salsa",
    imageUrl: "assets/images/tacos.png",
    calories: "500",
    protein: "20",
    prepTime: "20",
  ),
  Recipe(
    id: "5",
    name: "Pasta Alfredo",
    description:
        "Fettuccine pasta tossed in a rich, creamy parmesan cheese sauce",
    imageUrl: "assets/images/alfredo.png",
    calories: "800",
    protein: "15",
    prepTime: "15",
  ),
  Recipe(
    id: "6",
    name: "Cheese Pizza",
    description: "Crispy crust with tomato sauce and mozzarella cheese",
    imageUrl: "assets/images/pizza.png",
    calories: "700",
    protein: "20",
    prepTime: "40",
  ),
  Recipe(
    id: "7",
    name: "Hamburger",
    description:
        "Juicy beef patty with lettuce, tomato, onion and cheese on a bun",
    imageUrl: "assets/images/burger.png",
    calories: "650",
    protein: "25",
    prepTime: "15",
  ),
  Recipe(
    id: "8",
    name: "Chocolate Chip Cookies",
    description: "Chewy cookies filled with chocolate chips",
    imageUrl: "assets/images/cookies.png",
    calories: "200",
    protein: "3",
    prepTime: "30",
  ),
  Recipe(
    id: "9",
    name: "Chicken Fried Rice",
    description: "Rice stir-fried with chicken, vegetables and egg",
    imageUrl: "assets/images/rice.png",
    calories: "450",
    protein: "25",
    prepTime: "30",
  ),
];
