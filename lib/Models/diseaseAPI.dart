import 'package:flutter/foundation.dart';

// Infermedica API Condition
// https://developer.infermedica.com/docs/medical-concepts#conditions

class DiseaseAPI {
  final String id;
  final String name;
  final String commonName;
  final String sexFilter;
  final List<String> categories;
  final String prevalence; // chance to possible
  final String acuteness; //???
  final String severity; // Critical
  final Map<String, Object> extras; //etc

  DiseaseAPI({
    @required this.id,
    @required this.name,
    @required this.commonName,
    @required this.sexFilter,
    @required this.categories,
    @required this.prevalence,
    @required this.acuteness,
    @required this.severity,
    @required this.extras,
  });
}
