import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/my_navigator.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/login/presentation/blocs/login_with_qr/login_with_qr_bloc.dart';
import 'package:customer_club/features/login/presentation/screens/login_screen.dart';
import 'package:customer_club/features/login/presentation/screens/verify_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class LoginIntroScreen extends StatefulWidget {
  const LoginIntroScreen({super.key});

  @override
  State<LoginIntroScreen> createState() => _LoginIntroScreenState();
}

class _LoginIntroScreenState extends State<LoginIntroScreen>
    with WidgetsBindingObserver {
  LoginWithQrBloc _bloc = LoginWithQrBloc();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getIt<FlutterSecureStorage>().read(key: 'buyCardToken').then(
        (value) {
          if (_bloc.state is! LoginWithQrLoading && value.isNotNullOrEmpty) {
            _bloc.add(InqueryVirtualCardTokenEvent(token: value!));
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getIt<FlutterSecureStorage>().read(key: 'buyCardToken').then(
      (value) {
        if (_bloc.state is! LoginWithQrLoading && value.isNotNullOrEmpty) {
          _bloc.add(InqueryVirtualCardTokenEvent(token: value!));
        }
      },
    );
    WidgetsBinding.instance.addObserver(this);
    if (Platform.isAndroid) {
      ReceiveIntent.receivedIntentStream.listen((event) async {
        if (event?.extra != null &&
            event!.extra!['msg_from_browser'] != null &&
            event.extra!['msg_from_browser'].toString().contains(',')) {}
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: SvgPicture.string(MyIcons.profileWhite)),
          title: const Text(
            'حساب کاربری',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: SafeArea(
            child: BlocConsumer<LoginWithQrBloc, LoginWithQrState>(
          listener: (context, state) {
            if (state is LoginWithQrSuccess) {
              MyNavigator.pushReplacement(
                  context,
                  VerifyLoginScreen(
                    idCard: state.resModel.idCard,
                    isLogin: false,
                    isVirtualCard: true,
                  ));
            }
          },
          builder: (context, state) {
            return state is LoginWithQrLoading
                ? Center(
                    child: MyLoading(),
                  )
                : Container(
                    padding: EdgeInsets.only(bottom: 80),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CachedNetworkImage(
                              imageUrl: appConfig.appLogo ?? '',
                              width: 40.w(context)),
                          Column(
                            children: [
                              Text(
                                'برای ورود یا عضویت از گزینه زیر اقدام نمایید.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              24.hsb(),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          ColorPalette.primaryColor)),
                                  onPressed: () =>
                                      MyNavigator.push(context, LoginScreen()),
                                  child: Text('ورود / ثبت کارت')),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'توجه!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    6.hsb(),
                                    Text(
                                      appConfig.appBuyCard ?? '',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    final uuid = Uuid().v4();
                                    getIt<FlutterSecureStorage>().write(
                                        key: 'buyCardToken', value: uuid);
                                    List<int> bytes = utf8.encode(
                                        appConfig.passwordCreateToken ?? '');
                                    Digest md5Hash = md5.convert(bytes);
                                    final address =
                                        '${appConfig.requestCard}?platform=${Platform.isAndroid ? 'android' : 'ios'}&token=$uuid&password_create_token=${md5Hash}';
                                    log(address);
                                    launchUrl(Uri.parse(address),
                                        mode: LaunchMode.externalApplication,
                                        webOnlyWindowName: '_self');
                                  },
                                  child: Text(
                                    'خرید کارت',
                                    style: TextStyle(
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
          },
        )),
      ),
    );
  }
}
