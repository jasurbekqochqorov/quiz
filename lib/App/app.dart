import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/blocs/rank/rank_bloc.dart';
import 'package:quiz/blocs/test/test_bloc.dart';
import 'package:quiz/data/repositories/test_repository.dart';
import '../Screen/register_and_login/splash/splash_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../data/repositories/auth_repository.dart';

class App extends StatelessWidget {

  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => TestRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(appRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                TestBloc(testRepository: context.read<TestRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                RankBloc(testRepository: context.read<TestRepository>()),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (context, child) {
            ScreenUtil.init(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
              ),
              home: child,
            );
          },
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
