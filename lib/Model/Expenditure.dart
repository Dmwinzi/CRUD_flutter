class Expenditure {

  int? id;
  var name;
  var amount;

  Expenditure({this.id,required this.name,required this.amount});

  factory Expenditure.fromJson(Map<String,dynamic> json){
    return Expenditure(
      id : json["id"],
      name: json['name'],
      amount:  json['amount'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'amount' : amount,
    };
  }

}