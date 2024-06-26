
String? validateEmail(String? email){
  RegExp emailRegex= RegExp(r'^[\w\.-]+@[\w-]+\.[\w]{2,3}(\.[\w]{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email??"");
  if(!isEmailValid){
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(String? password){
  if(password==null){
    return 'Please type a password';
  }
  if(password.length<6){
    return'Your password should at least be 6 character';
  }
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Please confirm your password';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateUsername(String? username){
  if(username==null){
    return 'Please type a username';
  }
  if(username.length<6){
    return'Your username should at least be 6 character';
  }
  return null;
}