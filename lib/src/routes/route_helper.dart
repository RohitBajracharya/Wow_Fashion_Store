import 'package:admin_side/src/data/view/auth/login_screen.dart';
import 'package:admin_side/src/data/view/features/categories/add_categories_screen.dart';
import 'package:admin_side/src/data/view/features/categories/categories_screen.dart';
import 'package:admin_side/src/data/view/features/homeNsplash/home_screen.dart';
import 'package:admin_side/src/data/view/features/homeNsplash/splash_screen.dart';
import 'package:admin_side/src/data/view/features/products/add_product_screen.dart';
import 'package:admin_side/src/data/view/features/products/product_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String loginPage = "/login-page";
  static const String homePage = "/home-page";
  static const String categoriesPage = "/categories-page";
  static const String addCategoriesPage = "/add-categories-page";
  static const String productPage = "/product-page";
  static const String addProductPage = "/add-product-page";

  static String getInitial() => initial;
  static String getLoginPage() => loginPage;
  static String getHomePage() => homePage;
  static String getCategoriesPage() => categoriesPage;
  static String getAddCategoriesPage() => addCategoriesPage;
  static String getProductPage() => productPage;
  static String getAddProductPage() => addProductPage;

  static List<GetPage> routes = [
    //splash screen
    GetPage(name: initial, page: () => const SplashScreen()),
    //login screen
    GetPage(name: loginPage, page: () => const LoginScreen()),
    //home screen
    GetPage(name: homePage, page: () => const HomeScreen()),
    //categories screen
    GetPage(name: categoriesPage, page: () => const CategoriesScreen()),
    //add category screen
    GetPage(name: addCategoriesPage, page: () => const AddCategoriesScreen()),
    //product screen
    GetPage(name: productPage, page: () => const ProductScreen()),
    //add product screen
    GetPage(name: addProductPage, page: () => const AddProductScreen()),
  ];
}
