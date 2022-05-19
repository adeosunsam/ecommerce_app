import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/screen/login/login_screen.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigator extends StatefulWidget {
  final Function callbackFunction;
  const BottomNavigator({
    Key? key,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

int _selectedIndex = 0;
final List<String> _bottomNav = ['Home', 'heart', 'user', 'cart'];

List<CartProduct> getCartProducts = [];
onload() async {
  final cartList =
      await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
  if (cartList != null) {
    final productList = gadgetFromJson(cartList);
    getCartProducts = productList;
  } else {
    getCartProducts = [];
  }
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: onload(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: kPrimary,
                  backgroundColor: kbackground,
                  type: BottomNavigationBarType.fixed,
                  items: _bottomNav
                      .map(
                        (e) => BottomNavigationBarItem(
                          label: e,
                          icon: SvgPicture.asset(
                            'assets/icons/$e.svg',
                            color: _selectedIndex == _bottomNav.indexOf(e)
                                ? kPrimary
                                : Colors.black,
                          ),
                        ),
                      )
                      .toList(),
                  onTap: _onItemTapped,
                ),
              ),
              getCartProducts.isNotEmpty
                  ? Positioned(
                      right: getCartProducts.length > 9 ? 40 : 43,
                      bottom: getCartProducts.length > 9 ? 27 : 25,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              getCartProducts.length > 9 ? 2 : 4),
                          child: Text(
                            '${getCartProducts.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : const Padding(padding: EdgeInsets.zero),
            ],
          );
        });
  }

  _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    // context.read<AuthBloc>().add(const AuthEventGetUser());
    // BlocConsumer<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     if (state.isLoading) {
    //       LoadingScreen().show(
    //         context: context,
    //         text: state.loadingText ?? 'Please wait a moment',
    //       );
    //     } else {
    //       LoadingScreen().hide();
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is AuthStateLoggedUser ||
    //         state is AuthStateLoggedIn ||
    //         _selectedIndex != 2) {
    //       return widget.callbackFunction(_selectedIndex);
    //     } else if (state is AuthStateLoggedOut) {
    //       return const LoginScreen();
    //     } else {
    //       return const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //   },
    // );
    final getUser =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.user);
    bool isUserPresent = getUser != null ? true : false;

    if (isUserPresent) {
      UserData currentUser = userFromJson(getUser);
      widget.callbackFunction(_selectedIndex, currentUser.data);
    } else if (!isUserPresent && _selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      widget.callbackFunction(_selectedIndex, null);
    }
  }
}
