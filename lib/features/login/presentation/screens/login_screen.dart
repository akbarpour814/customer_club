import 'dart:async';
import 'dart:io';

import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/configs/gen/fonts.gen.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/custom_modals.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/my_navigator.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/login/presentation/blocs/login_with_qr/login_with_qr_bloc.dart';
import 'package:customer_club/features/login/presentation/blocs/verfiy_login/verify_login_bloc.dart';
import 'package:customer_club/features/login/presentation/screens/verify_login_screen.dart';
import 'package:customer_club/features/login/presentation/widgets/login_with_mobile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Timer? _timer;
  bool _tick = false;
  bool _first = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        _tick = !_tick;
        setState(() {});
      });
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: SvgPicture.string(MyIcons.scan)),
        title: const Text(
          'ورود / عضویت',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorPalette.primaryColor,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 36),
          child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade200,
              indicatorColor: Colors.white,
              unselectedLabelStyle: TextStyle(
                  fontFamily: FontFamily.estedad, fontSize: 3.6.w(context)),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.estedad,
                  fontSize: 3.6.w(context)),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              labelPadding: EdgeInsets.symmetric(vertical: 8),
              tabs: [
                Text('ورود از طریق موبایل'),
                Text('ورود از طریق ثبت کارت'),
              ]),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginWithQrBloc(),
          ),
          BlocProvider(
            create: (context) => VerifyLoginBloc(),
          ),
        ],
        child: SafeArea(
            child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            LoginWithMobileWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      appConfig.appRegisterCard ?? appConfig.appBuyCard ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  8.hsb(),
                  Assets.resources.qrCodeScan.svg(width: 40.w(context)),
                  4.h(context).hsb(),
                  Text(
                    'کارت خود را اسکن کنید و ادامه دهید',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  24.hsb(),
                  BlocConsumer<LoginWithQrBloc, LoginWithQrState>(
                    listener: (context, state) {
                      if (state is LoginWithQrError) {
                        CustomModal.showError(context, state.message);
                      }
                      if (state is LoginWithQrSuccess) {
                        MyNavigator.pushReplacement(
                            context,
                            VerifyLoginScreen(
                              idCard: state.resModel.idCard,
                              isLogin: state.resModel.isLogin,
                            ));
                      }
                    },
                    builder: (_, state) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Builder(builder: (context) {
                          return SizedBox(
                            width: 60.w(context),
                            height: 60.w(context),
                            child: state is LoginWithQrLoading
                                ? MyLoading()
                                : Stack(
                                    children: [
                                      QRView(
                                        key: qrKey,
                                        onQRViewCreated:
                                            (QRViewController controller) {
                                          this.controller = controller;
                                          controller.scannedDataStream
                                              .listen((scanData) {
                                            if (DateTime.now().second.isOdd) {
                                              if (!_first) {
                                                _first = true;
                                                if (state
                                                        is! LoginWithQrLoading &&
                                                    scanData.code
                                                        .isNotNullOrEmpty) {
                                                  BlocProvider.of<
                                                              LoginWithQrBloc>(
                                                          context)
                                                      .add(
                                                          LoginWithQrRequestEvent(
                                                              qr: scanData
                                                                      .code ??
                                                                  ''));
                                                }
                                              }
                                            }
                                          });
                                        },
                                      ),
                                      Positioned.fill(
                                          child: Center(
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 150),
                                          width: 50.w(context),
                                          color: ColorPalette.primaryColor,
                                          height: _tick ? 1 : 0,
                                        ),
                                      )),
                                      Positioned(
                                          top: 8,
                                          left: 8,
                                          right: 8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 2,
                                                height: 40,
                                              ),
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 2,
                                                height: 40,
                                              ),
                                            ],
                                          )),
                                      Positioned(
                                          top: 8,
                                          left: 8,
                                          right: 8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 40,
                                                height: 2,
                                              ),
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 40,
                                                height: 2,
                                              ),
                                            ],
                                          )),
                                      Positioned(
                                          top: 8,
                                          left: 8,
                                          right: 8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 2,
                                                height: 40,
                                              ),
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 2,
                                                height: 40,
                                              ),
                                            ],
                                          )),
                                      Positioned(
                                          bottom: 8,
                                          left: 8,
                                          right: 8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 40,
                                                height: 2,
                                              ),
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 40,
                                                height: 2,
                                              ),
                                            ],
                                          )),
                                      Positioned(
                                          bottom: 8,
                                          left: 8,
                                          right: 8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 2,
                                                height: 40,
                                              ),
                                              Container(
                                                color:
                                                    ColorPalette.primaryColor,
                                                width: 2,
                                                height: 40,
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
