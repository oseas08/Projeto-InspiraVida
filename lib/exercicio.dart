class Exercicio {
  late String name;
  late String muscle;
  late String equipment;

  late String instructions;

  Exercicio(
      { required this.name,
        required this.muscle,
        required this.equipment,
        required  this.instructions});

  Exercicio.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    muscle = json['muscle'] ?? '';
    equipment = json['equipment'] ?? '';
    instructions = json['instructions'] ?? '';
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['muscle'] = this.muscle;
    data['equipment'] = this.equipment;
    data['instructions'] = this.instructions;
    return data;
  }
}