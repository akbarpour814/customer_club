import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/custom_modals.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/my_navigator.dart';
import 'package:customer_club/core/utils/utils.dart';
import 'package:customer_club/core/utils/validators.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/login/data/models/login_with_qr_request_model.dart';
import 'package:customer_club/features/login/presentation/blocs/verfiy_login/verify_login_bloc.dart';
import 'package:customer_club/features/login/presentation/screens/profile_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class LoginWithMobileWidget extends StatefulWidget {
  const LoginWithMobileWidget({super.key});

  @override
  State<LoginWithMobileWidget> createState() => _LoginWithMobileWidgetState();
}

class _LoginWithMobileWidgetState extends State<LoginWithMobileWidget> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode _passNode = FocusNode();
  bool _obscurePass = true;
  String _passIcon = MyIcons.eyeBlack;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyLoginBloc, VerifyLoginState>(
      listener: (context, state) {
        if (state is VerifyLoginSuccess) {
          tokenNotifire.value = state.token;
          MyNavigator.pushReplacement(context, ProfileScreen());
        }
        if (state is VerifyLoginError) {
          CustomModal.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            children: [
              Text(
                appConfig.appLoginCard ?? appConfig.appBuyCard ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              40.hsb(),
              Assets.resources.loginShape.svg(width: 40.w(context)),
              5.h(context).hsb(),
              TextFormField(
                controller: _mobileController,
                maxLines: 1,
                textDirection: TextDirection.ltr,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
                keyboardType: textInputType(TypeEnum.mobile),
                inputFormatters: typeInputFormatters(TypeEnum.mobile),
                onFieldSubmitted: (_) {
                  _passNode.requestFocus();
                },
                decoration: InputDecoration(
                    label: Text('شماره موبایل'),
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: 30, minWidth: 30),
                    prefixIcon: SizedBox(
                      width: 20,
                      child: Center(
                        child: SvgPicture.string(
                          MyIcons.mobile,
                          width: 20,
                        ),
                      ),
                    )),
                validator: (value) => mobileNumberValidator(value),
              ),
              16.hsb(),
              TextFormField(
                focusNode: _passNode,
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                onFieldSubmitted: (_) => _enter(state, context),
                obscureText: _obscurePass,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
                keyboardType: textInputType(TypeEnum.password),
                inputFormatters: typeInputFormatters(TypeEnum.password),
                decoration: InputDecoration(
                  label: Text('رمز عبور'),
                  prefixIconConstraints:
                      BoxConstraints(maxWidth: 30, minWidth: 30),
                  prefixIcon: SizedBox(
                    width: 20,
                    child: Center(
                      child: SvgPicture.string(
                        MyIcons.passwordPrimary,
                        width: 20,
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass;
                        _passIcon = _obscurePass
                            ? MyIcons.eyeBlack
                            : MyIcons.removeEyeBlck;
                      });
                    },
                    icon: SvgPicture.string(
                      _passIcon,
                      width: 20,
                    ),
                  ),
                ),
                validator: passwordValidator,
              ),
              40.hsb(),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(ColorPalette.primaryColor)),
                  onPressed: () {
                    _enter(state, context);
                  },
                  child: state is VerifyLoginLoading
                      ? MyLoading(
                          withText: false,
                          color: Colors.white,
                        )
                      : Text('ورود'))
            ],
          ),
        );
      },
    );
  }

  Future<void> _enter(VerifyLoginState state, BuildContext context) async {
    if (state is! VerifyLoginLoading) {
      if (_formKey.currentState!.validate()) {
        BlocProvider.of<VerifyLoginBloc>(context).add(VerifyLoginRequestEvent(
            requestModel: LoginWithQrRequestModel(
                fcmToken: await FirebaseMessaging.instance.getToken(),
                mobile: _mobileController.text.trim().toEnglishDigit(),
                password: _passwordController.text.trim())));
      }
    }
  }
}
