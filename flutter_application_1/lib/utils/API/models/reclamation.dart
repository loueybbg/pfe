class Reclamation {
  final int reclamationId;
  final String name;
  final String adress;

  const Reclamation(
      {required this.reclamationId, required this.name, required this.adress});

  factory Reclamation.fromJson(Map<String, dynamic> json) => Reclamation(
      reclamationId: json['userId'],
      name: json['name'],
      adress: json['adress']);

  Map<String, dynamic> toJson() => {
        "userId": reclamationId,
        "name": name,
        "adress": adress,
      };
}
