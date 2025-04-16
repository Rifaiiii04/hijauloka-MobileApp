class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Accept any valid email and non-empty password
    if (email.isNotEmpty && password.isNotEmpty) {
      return {
        'name': email.split('@')[0], // Use email username as name
        'email': email,
        'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      };
    } else {
      throw Exception('Email and password are required');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      return {
        'name': name,
        'email': email,
        'message': 'Registration successful',
      };
    } else {
      throw Exception('All fields are required');
    }
  }
}