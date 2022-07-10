import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_store/screen/cart/product_cart.dart';
import 'package:ecommerce_store/screen/detail/product_detail.dart';
import 'package:ecommerce_store/screen/favorite/fav_page.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/screen/home/components/product.dart';
import 'package:ecommerce_store/screen/profile/user_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: ProductPage,
      children: [
        AutoRoute(
          path: 'home',
          name: "HomeRouter",
          page: Body,
          // page: EmptyRouterPage,
          // children: [
          //   AutoRoute(
          //     path: '',
          //     page: Body,
          //   ),
          //   AutoRoute(
          //     path: ':productId',
          //     page: ProductDetailScreen,
          //   ),
          // ],
        ),
        AutoRoute(
          path: 'favorite',
          name: "FavoriteRouter",
          page: FavoriteScreen,
        ),
        AutoRoute(
          path: 'user',
          name: "UsersRouter",
          page: UserProfileScreen,
        ),
        AutoRoute(
          path: 'cart',
          name: "CartRouter",
          page: CartScreen,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
