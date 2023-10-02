class Env {
  Env._privateConstructor({required this.url, required this.apiKey});

  final String url;
  final String apiKey;

  static Env? _instance;

  // ignore: prefer_constructors_over_static_methods
  static Env get instance {
    if (_instance != null) return _instance!;
    _instance = Env._privateConstructor(
      apiKey: const String.fromEnvironment('API_KEY'),
      url: const String.fromEnvironment('URL'),
    );
    return _instance!;
  }
}
