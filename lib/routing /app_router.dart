import 'package:auto_route/auto_route.dart';
import 'package:empoverty/pages/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{
  List<AutoRoute> get routes => [
    AutoRoute(
        page: SplashRoute.page,
        path: "/splash",
        initial: true
    ),
  ];
}