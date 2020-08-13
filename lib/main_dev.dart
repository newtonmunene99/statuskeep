import 'package:statuskeep/app.dart';
import 'package:statuskeep/config/flavors.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  FlavorConfig(
    flavor: Flavor.DEV,
    color: Colors.red,
    values: FlavorValues(),
  );

  runApp(StatusKeepApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print("${rec.level.name}: ${rec.time}: ${rec.message}");
  });
}
