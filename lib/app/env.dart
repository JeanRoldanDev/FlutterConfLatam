class Env {
  Env._privateConstructor({
    required this.url,
    required this.apiKey,
    required this.serverView3dDentalURL,
  });

  final String url;
  final String apiKey;
  final String serverView3dDentalURL;

  static Env? _instance;

  // ignore: prefer_constructors_over_static_methods
  static Env get instance {
    if (_instance != null) return _instance!;
    _instance = Env._privateConstructor(
      apiKey: const String.fromEnvironment('API_KEY'),
      url: const String.fromEnvironment('URL'),
      serverView3dDentalURL:
          const String.fromEnvironment('SERVER_VIEW_3D_DENTAL_URL'),
    );
    return _instance!;
  }
}
