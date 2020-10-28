class Candidate {
  final int id;
  String companyName;
  String email;
  String response;
  Candidate({this.id, this.companyName, this.email, this.response});

  factory Candidate.fromMap(Map<String, dynamic> map) {
    return Candidate(
        id: int.parse(map['id'].toString()),
        companyName: map['company_name'],
        email: map['email'],
        response: map['response']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company_name': companyName,
      'email': email,
      'response': response
    };
  }
}
