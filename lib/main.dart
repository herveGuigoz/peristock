import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peristock/bootstrap.dart';
import 'package:peristock/presentation/app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(url: dotenv.get('SUPABASE_URL'), anonKey: dotenv.get('ANON_KEY'));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await bootstrap(() => const App());
}
