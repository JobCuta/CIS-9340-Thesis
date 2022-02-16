class LoginForm {
  late String email;
  late String pass;

  Map<String, String> form() {
    return {"email": email, "password": pass};
  }
}

class RegisterForm {
  late String email;
  late String pass1;
  late String pass2;

  Map<String, String> form() {
    return {"email": email, "password1": pass1, "password2": pass2};
  }
}

class UserForm {
  late int id;
  late String email;
  late String fname;
  late String lname;
  late String bday;
  late String gender;

  Map<String, dynamic> form() {
    return {
      "id": id,
      "email": email,
      "first_name": fname,
      "last_name": lname,
      "date_of_birth": bday,
      "gender": gender,
    };
  }
}
