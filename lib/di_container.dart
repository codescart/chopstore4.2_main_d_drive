import 'package:dio/dio.dart';
import 'package:chopstore/data/repository/auth_repo.dart';
import 'package:chopstore/data/repository/banner_repo.dart';
import 'package:chopstore/data/repository/cart_repo.dart';
import 'package:chopstore/data/repository/category_repo.dart';
import 'package:chopstore/data/repository/chat_repo.dart';
import 'package:chopstore/data/repository/coupon_repo.dart';
import 'package:chopstore/data/repository/language_repo.dart';
import 'package:chopstore/data/repository/location_repo.dart';
import 'package:chopstore/data/repository/notification_repo.dart';
import 'package:chopstore/data/repository/onboarding_repo.dart';
import 'package:chopstore/data/repository/order_repo.dart';
import 'package:chopstore/data/repository/product_details_repo.dart';
import 'package:chopstore/data/repository/product_repo.dart';
import 'package:chopstore/data/repository/profile_repo.dart';
import 'package:chopstore/data/repository/search_repo.dart';
import 'package:chopstore/data/repository/splash_repo.dart';
import 'package:chopstore/provider/auth_provider.dart';
import 'package:chopstore/provider/banner_provider.dart';
import 'package:chopstore/provider/cart_provider.dart';
import 'package:chopstore/provider/category_provider.dart';
import 'package:chopstore/provider/chat_provider.dart';
import 'package:chopstore/provider/coupon_provider.dart';
import 'package:chopstore/provider/language_provider.dart';
import 'package:chopstore/provider/localization_provider.dart';
import 'package:chopstore/provider/location_provider.dart';
import 'package:chopstore/provider/news_letter_provider.dart';
import 'package:chopstore/provider/notification_provider.dart';
import 'package:chopstore/provider/onboarding_provider.dart';
import 'package:chopstore/provider/order_provider.dart';
import 'package:chopstore/provider/product_provider.dart';
import 'package:chopstore/provider/profile_provider.dart';
import 'package:chopstore/provider/search_provider.dart';
import 'package:chopstore/provider/splash_provider.dart';
import 'package:chopstore/provider/theme_provider.dart';
import 'package:chopstore/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/news_letter_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ChatRepo(dioClient: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CouponRepo(dioClient: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LocationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => BannerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(() => NewsLetterRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl(), searchRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl(),notificationRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  sl.registerFactory(() => LocationProvider(locationRepo: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => NewsLetterProvider(newsLetterRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
