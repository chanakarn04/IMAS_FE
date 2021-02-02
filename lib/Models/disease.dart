import 'package:flutter/foundation.dart';

// Non API

class Disease {
  final String id;
  final String name;
  final String description;
  final List<String> treatment;
  final String cause;

  Disease({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.treatment,
    @required this.cause,
  });
}
