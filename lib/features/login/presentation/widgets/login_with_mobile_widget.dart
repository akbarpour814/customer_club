import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/utils.dart';
import 'package:customer_club/core/utils/validators.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        Text(
          appConfig.appLoginCard ?? appConfig.appBuyCard ?? '',
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        10.h(context).hsb(),
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
              prefixIconConstraints: BoxConstraints(maxWidth: 30, minWidth: 30),
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
          textInputAction: TextInputAction.go,
          maxLines: 1,
          onFieldSubmitted: (_) {},
          obscureText: _obscurePass,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          keyboardType: textInputType(TypeEnum.password),
          inputFormatters: typeInputFormatters(TypeEnum.password),
          decoration: InputDecoration(
            label: Text('رمز عبور'),
            prefixIconConstraints: BoxConstraints(maxWidth: 30, minWidth: 30),
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
                  _passIcon =
                      _obscurePass ? MyIcons.eyeBlack : MyIcons.removeEyeBlck;
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
            onPressed: () {},
            child: false
                ? MyLoading(
                    withText: false,
                    color: Colors.white,
                  )
                : Text('ورود'))
      ],
    );
  }
}
