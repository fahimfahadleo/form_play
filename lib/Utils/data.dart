class Data {
  String email;
  int id;
  String firstName;
  String lastName;

//[{id: 1, email: george.bluth@reqres.in, first_name: George, last_name: Bluth, avatar: https://reqres.in/img/faces/1-image.jpg},
// {id: 2, email: janet.weaver@reqres.in, first_name: Janet, last_name: Weaver, avatar: https://reqres.in/img/faces/2-image.jpg},
// {id: 3, email: emma.wong@reqres.in, first_name: Emma, last_name: Wong, avatar: https://reqres.in/img/faces/3-image.jpg},
// {id: 4, email: eve.holt@reqres.in, first_name: Eve, last_name: Holt, avatar: https://reqres.in/img/faces/4-image.jpg},
// {id: 5, email: charles.morris@reqres.in, first_name: Charles, last_name: Morris, avatar: https://reqres.in/img/faces/5-image.jpg},
// {id: 6, email: tracey.ramos@reqres.in, first_name: Tracey, last_name: Ramos, avatar: https://reqres.in/img/faces/6-image.jpg}]
  Data(this.email, this.id,this.firstName,this.lastName);

  int getID(){
    return id;
  }

  String getEmail(){
    return email;
  }
  String getFirstName(){
    return firstName;
  }
  String getLastName(){
    return lastName;
  }

  factory Data.fromJson(dynamic json) {
    return Data(json['email'] as String, json['id'] as int, json['first_name'] as String, json['last_name'] as String);
  }

  @override
  String toString() {
    return '{ $email, $id, $firstName, $lastName }';
  }
}