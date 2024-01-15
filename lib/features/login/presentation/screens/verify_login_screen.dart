import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/custom_modals.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/utils.dart';
import 'package:customer_club/core/utils/validators.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/login/data/models/login_with_qr_request_model.dart';
import 'package:customer_club/features/login/presentation/blocs/verfiy_login/verify_login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class VerifyLoginScreen extends StatefulWidget {
  final String idCard;
  const VerifyLoginScreen({super.key, required this.idCard});

  @override
  State<VerifyLoginScreen> createState() => _VerifyLoginScreenState();
}

class _VerifyLoginScreenState extends State<VerifyLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cvv2Controller = TextEditingController();
  bool _obscurepass = true;
  String _passIcon = MyIcons.eyeBlack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: SvgPicture.string(MyIcons.userVerify)),
        title: const Text(
          'تایید کارت',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: BlocProvider(
        create: (context) => VerifyLoginBloc(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(12),
                  height: 44.w(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        ColorPalette.primaryColor,
                        ColorPalette.fontColor1
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'رویا کارت',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SvgPicture.string(MyIcons.creditCartDone),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.idCard.toPersianDigit(),
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      24.hsb()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            label: Text('نام'),
                            prefixIconConstraints:
                                BoxConstraints(maxWidth: 30, minWidth: 30),
                            prefixIcon: SizedBox(
                              width: 20,
                              child: Center(
                                child: SvgPicture.string(
                                  MyIcons.user,
                                  width: 20,
                                ),
                              ),
                            )),
                        validator: (value) => generalValidator(value, 'نام'),
                      ),
                      16.hsb(),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            label: Text('نام خانوادگی'),
                            prefixIconConstraints:
                                BoxConstraints(maxWidth: 30, minWidth: 30),
                            prefixIcon: SizedBox(
                              width: 20,
                              child: Center(
                                child: SvgPicture.string(
                                  MyIcons.user,
                                  width: 20,
                                ),
                              ),
                            )),
                        validator: (value) =>
                            generalValidator(value, 'نام خانوادگی'),
                      ),
                      16.hsb(),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: textInputType(TypeEnum.mobile),
                        inputFormatters: typeInputFormatters(TypeEnum.mobile),
                        decoration: InputDecoration(
                            label: Text('شماره موبایل'),
                            prefixIconConstraints:
                                BoxConstraints(maxWidth: 30, minWidth: 30),
                            prefixIcon: SizedBox(
                              width: 20,
                              child: Center(
                                child: SvgPicture.string(
                                  MyIcons.mobileBlack,
                                  width: 20,
                                ),
                              ),
                            )),
                        validator: (value) => mobileNumberValidator(value),
                      ),
                      16.hsb(),
                      TextFormField(
                        controller: _cvv2Controller,
                        obscureText: _obscurepass,
                        keyboardType: textInputType(TypeEnum.cvv2),
                        inputFormatters: typeInputFormatters(TypeEnum.cvv2),
                        decoration: InputDecoration(
                          label: Text('CVV2'),
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: 30, minWidth: 30),
                          prefixIcon: SizedBox(
                            width: 20,
                            child: Center(
                              child: SvgPicture.string(
                                MyIcons.password,
                                width: 20,
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurepass = !_obscurepass;
                                _passIcon = _obscurepass
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
                        validator: (value) {
                          if (value == null || value.length != 4) {
                            return 'لطفا CVV2 را به درستی وارد نمایید';
                          }
                          return null;
                        },
                      ),
                      16.hsb(),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            label: Text('نام کاربری'),
                            prefixIconConstraints:
                                BoxConstraints(maxWidth: 30, minWidth: 30),
                            prefixIcon: SizedBox(
                              width: 20,
                              child: Center(
                                child: SvgPicture.string(
                                  MyIcons.user,
                                  width: 20,
                                ),
                              ),
                            )),
                        validator: (value) =>
                            generalValidator(value, 'نام کاربری'),
                      ),
                      24.hsb(),
                      BlocConsumer<VerifyLoginBloc, VerifyLoginState>(
                        listener: (context, state) {
                          if (state is VerifyLoginSuccess) {
                            CustomModal.showSuccess(context, 'خوش آمدید');
                            tokenNotifire.value = state.token;
                          }
                          if (state is VerifyLoginError) {
                            CustomModal.showError(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorPalette.primaryColor)),
                              onPressed: () {
                                if (state is! VerifyLoginLoading) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<VerifyLoginBloc>(context)
                                        .add(VerifyLoginRequestEvent(
                                            requestModel:
                                                LoginWithQrRequestModel(
                                                    fname: _nameController.text
                                                        .trim(),
                                                    lname: _lastNameController
                                                        .text
                                                        .trim(),
                                                    mobile: _mobileController
                                                        .text
                                                        .trim(),
                                                    username: _usernameController
                                                        .text
                                                        .trim(),
                                                    cvv2: _cvv2Controller.text
                                                        .trim(),
                                                    idcard: widget.idCard)));
                                  }
                                }
                              },
                              child: state is VerifyLoginLoading
                                  ? MyLoading(
                                      withText: false,
                                      color: Colors.white,
                                    )
                                  : Text('تایید اطلاعات'));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
