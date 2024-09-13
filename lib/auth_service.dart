class AuthService {
  Future<bool> login(String email, String password) async {
    // Replace with actual API request
    const hardcodedEmail = '123@test.com';
    const hardcodedPassword = 'test';

    if (email == hardcodedEmail && password == hardcodedPassword) {
      return true; // Simulate successful login
    } else {
      return false; // Simulate login failure
    }
  }
}
