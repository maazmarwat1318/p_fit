import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepoProvider = Provider(
  (ref) => HomeRepo(),
);

class HomeRepo {}
