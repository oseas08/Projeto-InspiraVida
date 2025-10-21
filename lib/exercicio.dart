class Exercicio {
  late String name;
  late String type;
  late String muscle;
  late String equipment;
  late String difficulty;
  late String instructions;

  Exercicio(
      { required this.name,
        required this.type,
        required this.muscle,
        required this.equipment,
        required  this.difficulty,
        required  this.instructions});

  Exercicio.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    type = json['type']  ?? '';
    muscle = json['muscle'] ?? '';
    equipment = json['equipment'] ?? '';
    difficulty = json['difficulty'] ?? '';
    instructions = json['instructions'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['muscle'] = this.muscle;
    data['equipment'] = this.equipment;
    data['difficulty'] = this.difficulty;
    data['instructions'] = this.instructions;
    return data;
  }
}