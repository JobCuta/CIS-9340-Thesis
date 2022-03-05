class LoginForm {
  late String email;
  late String pass;

  LoginForm(this.email, this.pass);

  Map<String, String> form() {
    return {"email": email, "password": pass};
  }
}

class RegisterForm {
  late String email;
  late String pass1;
  late String pass2;
  late String fname;
  late String lname;
  late String nickn;
  late String bday;
  late String gender;

  RegisterForm(this.email, this.pass1, this.pass2, this.fname, this.lname,
      this.nickn, this.bday, this.gender);

  Map<String, String> form() {
    return {
      "email": email,
      "password1": pass1,
      "password2": pass2,
      "first_name": fname,
      "last_name": lname,
      "nickname": nickn,
      "date_of_birth": bday,
      "gender": gender,
    };
  }
}
