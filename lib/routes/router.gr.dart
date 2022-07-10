// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screen/cart/product_cart.dart' as _i5;
import '../screen/favorite/fav_page.dart' as _i3;
import '../screen/home/components/product.dart' as _i2;
import '../screen/home/home_page.dart' as _i1;
import '../screen/profile/user_page.dart' as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>(
          orElse: () => const ProductRouteArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.ProductPage(
              key: args.key, bottomNavigatorIndex: args.bottomNavigatorIndex));
    },
    HomeRouter.name: (routeData) {
      final args = routeData.argsAs<HomeRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.Body(
              key: args.key,
              controller: args.controller,
              scaleAnimation: args.scaleAnimation,
              oncallbackFuntion: args.oncallbackFuntion));
    },
    FavoriteRouter.name: (routeData) {
      final args = routeData.argsAs<FavoriteRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.FavoriteScreen(
              key: args.key,
              controller: args.controller,
              scaleAnimation: args.scaleAnimation,
              oncallbackFuntion: args.oncallbackFuntion));
    },
    UsersRouter.name: (routeData) {
      final args = routeData.argsAs<UsersRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.UserProfileScreen(
              key: args.key,
              controller: args.controller,
              scaleAnimation: args.scaleAnimation,
              oncallbackFuntion: args.oncallbackFuntion));
    },
    CartRouter.name: (routeData) {
      final args = routeData.argsAs<CartRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CartScreen(
              key: args.key, callbackFunction: args.callbackFunction));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(ProductRoute.name, path: '/', children: [
          _i6.RouteConfig(HomeRouter.name,
              path: 'home', parent: ProductRoute.name),
          _i6.RouteConfig(FavoriteRouter.name,
              path: 'favorite', parent: ProductRoute.name),
          _i6.RouteConfig(UsersRouter.name,
              path: 'user', parent: ProductRoute.name),
          _i6.RouteConfig(CartRouter.name,
              path: 'cart', parent: ProductRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.ProductPage]
class ProductRoute extends _i6.PageRouteInfo<ProductRouteArgs> {
  ProductRoute(
      {_i7.Key? key,
      int? bottomNavigatorIndex,
      List<_i6.PageRouteInfo>? children})
      : super(ProductRoute.name,
            path: '/',
            args: ProductRouteArgs(
                key: key, bottomNavigatorIndex: bottomNavigatorIndex),
            initialChildren: children);

  static const String name = 'ProductRoute';
}

class ProductRouteArgs {
  const ProductRouteArgs({this.key, this.bottomNavigatorIndex});

  final _i7.Key? key;

  final int? bottomNavigatorIndex;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, bottomNavigatorIndex: $bottomNavigatorIndex}';
  }
}

/// generated route for
/// [_i2.Body]
class HomeRouter extends _i6.PageRouteInfo<HomeRouterArgs> {
  HomeRouter(
      {_i7.Key? key,
      required _i7.AnimationController controller,
      required _i7.Animation<double> scaleAnimation,
      required Function oncallbackFuntion})
      : super(HomeRouter.name,
            path: 'home',
            args: HomeRouterArgs(
                key: key,
                controller: controller,
                scaleAnimation: scaleAnimation,
                oncallbackFuntion: oncallbackFuntion));

  static const String name = 'HomeRouter';
}

class HomeRouterArgs {
  const HomeRouterArgs(
      {this.key,
      required this.controller,
      required this.scaleAnimation,
      required this.oncallbackFuntion});

  final _i7.Key? key;

  final _i7.AnimationController controller;

  final _i7.Animation<double> scaleAnimation;

  final Function oncallbackFuntion;

  @override
  String toString() {
    return 'HomeRouterArgs{key: $key, controller: $controller, scaleAnimation: $scaleAnimation, oncallbackFuntion: $oncallbackFuntion}';
  }
}

/// generated route for
/// [_i3.FavoriteScreen]
class FavoriteRouter extends _i6.PageRouteInfo<FavoriteRouterArgs> {
  FavoriteRouter(
      {_i7.Key? key,
      required _i7.AnimationController controller,
      required _i7.Animation<double> scaleAnimation,
      required Function oncallbackFuntion})
      : super(FavoriteRouter.name,
            path: 'favorite',
            args: FavoriteRouterArgs(
                key: key,
                controller: controller,
                scaleAnimation: scaleAnimation,
                oncallbackFuntion: oncallbackFuntion));

  static const String name = 'FavoriteRouter';
}

class FavoriteRouterArgs {
  const FavoriteRouterArgs(
      {this.key,
      required this.controller,
      required this.scaleAnimation,
      required this.oncallbackFuntion});

  final _i7.Key? key;

  final _i7.AnimationController controller;

  final _i7.Animation<double> scaleAnimation;

  final Function oncallbackFuntion;

  @override
  String toString() {
    return 'FavoriteRouterArgs{key: $key, controller: $controller, scaleAnimation: $scaleAnimation, oncallbackFuntion: $oncallbackFuntion}';
  }
}

/// generated route for
/// [_i4.UserProfileScreen]
class UsersRouter extends _i6.PageRouteInfo<UsersRouterArgs> {
  UsersRouter(
      {_i7.Key? key,
      required _i7.AnimationController controller,
      required _i7.Animation<double> scaleAnimation,
      required Function oncallbackFuntion})
      : super(UsersRouter.name,
            path: 'user',
            args: UsersRouterArgs(
                key: key,
                controller: controller,
                scaleAnimation: scaleAnimation,
                oncallbackFuntion: oncallbackFuntion));

  static const String name = 'UsersRouter';
}

class UsersRouterArgs {
  const UsersRouterArgs(
      {this.key,
      required this.controller,
      required this.scaleAnimation,
      required this.oncallbackFuntion});

  final _i7.Key? key;

  final _i7.AnimationController controller;

  final _i7.Animation<double> scaleAnimation;

  final Function oncallbackFuntion;

  @override
  String toString() {
    return 'UsersRouterArgs{key: $key, controller: $controller, scaleAnimation: $scaleAnimation, oncallbackFuntion: $oncallbackFuntion}';
  }
}

/// generated route for
/// [_i5.CartScreen]
class CartRouter extends _i6.PageRouteInfo<CartRouterArgs> {
  CartRouter({_i7.Key? key, required Function callbackFunction})
      : super(CartRouter.name,
            path: 'cart',
            args: CartRouterArgs(key: key, callbackFunction: callbackFunction));

  static const String name = 'CartRouter';
}

class CartRouterArgs {
  const CartRouterArgs({this.key, required this.callbackFunction});

  final _i7.Key? key;

  final Function callbackFunction;

  @override
  String toString() {
    return 'CartRouterArgs{key: $key, callbackFunction: $callbackFunction}';
  }
}
