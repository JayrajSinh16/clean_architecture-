import 'package:clean/core/secrets/app_secrets.dart';
import 'package:clean/core/theme/theme.dart';
import 'package:clean/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/auth/presentation/pages/signup_page.dart';
// import 'package:clean/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initDependencies();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supaAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(supabase.client),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
