import 'dart:developer';

import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_navigator.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/home/presentation/blocs/get_home_data/get_home_data_bloc.dart';
import 'package:customer_club/features/home/presentation/screens/main_screen.dart';
import 'package:customer_club/features/login/presentation/blocs/get_app_config/get_app_config_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // getIt<FlutterSecureStorage>().deleteAll();
    getIt<FlutterSecureStorage>().read(key: 'token').then((value) {
      if (value.isNotNullOrEmpty) {
        log(value!);
        tokenNotifire.value = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAppConfigBloc()..add(GetAppConfigStartEvent()),
      child: BlocListener<GetHomeDataBloc, GetHomeDataState>(
        listener: (context, getHomeDataState) {
          if (getHomeDataState is GetHomeDataLoaded) {
            MyNavigator.pushReplacement(
                context,
                MainScreen(
                  key: MainScreen.stateKey,
                ));
          }
        },
        child: BlocListener<GetAppConfigBloc, GetAppConfigState>(
          listener: (context, state) {
            if (state is GetAppConfigLoaded) {
              appConfig = state.configModel;
              if (state.configModel.colorMasterApp.isNotNullOrEmpty) {
                ColorPalette.primaryColor =
                    Color(int.parse('0xff${state.configModel.colorMasterApp}'));
                ColorPalette.primaryColorHex =
                    state.configModel.colorMasterApp!;
              }
              if (state.configModel.colorClientApp.isNotNullOrEmpty) {
                ColorPalette.secondryColor =
                    Color(int.parse('0xff${state.configModel.colorClientApp}'));
              }
              BlocProvider.of<GetHomeDataBloc>(context)
                  .add(GetHomeDataStartEvent());
            }
          },
          child: Scaffold(
            backgroundColor: ColorPalette.primaryColor,
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      80.hsb(),
                      const Text(
                        'خوش آمدید',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      24.hsb(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.resources.splashVector.svg(width: 300),
                        ],
                      ),
                      24.hsb(),
                      SizedBox(
                          width: 200,
                          child: Text(
                            'جستجو در بیش از 1000 فروشگاه تخفیفی در شهر شما'
                                .toPersianDigit(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                80.hsb(
                    child: const MyLoading(
                  color: Colors.white,
                  withText: false,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
