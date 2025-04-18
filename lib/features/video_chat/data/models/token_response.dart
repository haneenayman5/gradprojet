class TokenResponse {
  final String token;
  TokenResponse(this.token);
  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      TokenResponse(json['token'] as String);
}