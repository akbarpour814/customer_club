import 'dart:io';

import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/const.dart';
import 'package:customer_club/core/utils/custom_modals.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/image_picker.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/utils.dart';
import 'package:customer_club/core/utils/validators.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/core/widgets/my_icon_button.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/login/data/models/city_model.dart';
import 'package:customer_club/features/login/data/models/user_model.dart';
import 'package:customer_club/features/login/presentation/blocs/get_profile/get_profile_bloc.dart';
import 'package:customer_club/features/login/presentation/blocs/update_profile/update_profile_bloc.dart';
import 'package:customer_club/features/login/presentation/blocs/upload_avatar/upload_avatar_bloc.dart';
import 'package:customer_club/features/login/presentation/widgets/city/city_drobdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  File? _pickedImage;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePass = true;
  String _passIcon = MyIcons.eyeBlack;
  FocusNode _passNode = FocusNode();
  CityModel? _selectedCity;
  String? _uploadedAvatarLink;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProfileBloc()..add(GetProfileStartEvent()),
        ),
        BlocProvider(
          create: (context) => UploadAvatarBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: SvgPicture.string(MyIcons.profileWhite)),
          title: const Text(
            'حساب کاربری',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            MyIconButton(
                onTap: () {},
                child: SvgPicture.string(
                  MyIcons.store,
                  width: 22,
                )),
            _menu(),
          ],
          centerTitle: true,
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: BlocConsumer<GetProfileBloc, GetProfileState>(
          listener: (context, state) {
            if (state is GetProfileLoaded) {
              _userNameController.text = state.user.username ?? '';
              _firstNameController.text = state.user.fname ?? '';
              _lastNameController.text = state.user.lname ?? '';
              _mobileController.text = state.user.mobile ?? '';
              _emailController.text = state.user.email ?? '';
              setState(() {});
            }
          },
          builder: (context, state) {
            return state is GetProfileLoaded
                ? Form(
                    key: _formKey,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 80),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocConsumer<UploadAvatarBloc, UploadAvatarState>(
                              listener: (context, uploadState) {
                                if (uploadState is UploadAvatarSuccess) {
                                  _uploadedAvatarLink = uploadState.link;
                                }
                              },
                              builder: (context, uploadState) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 24),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(18.w(context)),
                                      onTapDown: (details) {
                                        if (state is! UploadAvatarLoading) {
                                          imagePicker(context, details,
                                              isAlreadyPicked: _pickedImage !=
                                                  null, onPick: (file) {
                                            if (file != null) {
                                              setState(() {
                                                _pickedImage = file;
                                              });
                                              BlocProvider.of<UploadAvatarBloc>(
                                                      context)
                                                  .add(UploadAvatarStartEvent(
                                                      file: file));
                                            }
                                          });
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 36.w(context),
                                            height: 36.w(context),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: _pickedImage != null
                                                    ? DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: FileImage(
                                                            _pickedImage!))
                                                    : state.user.image
                                                            .isNotNullOrEmpty
                                                        ? DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                state.user
                                                                    .image!))
                                                        : null),
                                          ),
                                          Positioned(
                                              bottom: 8,
                                              left: 8,
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: ColorPalette
                                                        .primaryColor,
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  CupertinoIcons
                                                      .photo_camera_solid,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _firstNameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    label: Text('نام'),
                                    prefixIconConstraints: BoxConstraints(
                                        maxWidth: 30, minWidth: 30),
                                    prefixIcon: SizedBox(
                                      width: 20,
                                      child: Center(
                                        child: SvgPicture.string(
                                          MyIcons.userPrimary,
                                          width: 20,
                                        ),
                                      ),
                                    )),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'نام را وارد نمایید';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            8.wsb(),
                            Expanded(
                              child: TextFormField(
                                controller: _lastNameController,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    label: Text('نام خانوادگی'),
                                    prefixIconConstraints: BoxConstraints(
                                        maxWidth: 30, minWidth: 30),
                                    prefixIcon: SizedBox(
                                      width: 20,
                                      child: Center(
                                        child: SvgPicture.string(
                                          MyIcons.userPrimary,
                                          width: 20,
                                        ),
                                      ),
                                    )),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'نام خانوادگی را وارد نمایید';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        16.hsb(),
                        TextFormField(
                          controller: _userNameController,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              label: Text('نام کاربری'),
                              prefixIconConstraints:
                                  BoxConstraints(maxWidth: 30, minWidth: 30),
                              prefixIcon: SizedBox(
                                width: 20,
                                child: Center(
                                  child: SvgPicture.string(
                                    MyIcons.userPrimary,
                                    width: 20,
                                  ),
                                ),
                              )),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'نام کاربری را به درستی وارد نمایید';
                            }
                            if (value.characters
                                .any((element) => element.isPersian)) {
                              return 'نام کاربری باید لاتین باشد';
                            }
                            return null;
                          },
                        ),
                        16.hsb(),
                        TextFormField(
                          controller: _mobileController,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
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
                                    MyIcons.mobile,
                                    width: 20,
                                  ),
                                ),
                              )),
                          validator: (value) => mobileNumberValidator(value),
                        ),
                        8.hsb(),
                        Divider(
                          color: Colors.grey.shade200,
                        ),
                        8.hsb(),
                        TextFormField(
                          controller: _emailController,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
                          keyboardType: textInputType(TypeEnum.email),
                          inputFormatters: typeInputFormatters(TypeEnum.email),
                          decoration: InputDecoration(
                              label: Text('ایمیل'),
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
                          validator: (value) => emailValidator(value),
                        ),
                        16.hsb(),
                        CityListDrobDown(
                            onSelected: (selected) {
                              _selectedCity = selected;
                            },
                            selectCityId: state.user.shopId),
                        16.hsb(),
                        TextFormField(
                          focusNode: _passNode,
                          controller: _passwordController,
                          textInputAction: TextInputAction.go,
                          maxLines: 1,
                          obscureText: _obscurePass,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          keyboardType: textInputType(TypeEnum.password),
                          inputFormatters:
                              typeInputFormatters(TypeEnum.password),
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
                        24.hsb(),
                        BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                          listener: (context, updateState) {
                            if (updateState is UpdateProfileSuccess) {
                              CustomModal.showSuccess(
                                  context, 'حساب کاربری با موفقیت ذخیره شد');
                            }
                            if (updateState is UpdateProfileError) {
                              CustomModal.showError(
                                  context, updateState.message);
                            }
                          },
                          builder: (context, updateState) {
                            return ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorPalette.primaryColor)),
                                onPressed: () {
                                  if (updateState is! UpdateProfileLoading) {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<UpdateProfileBloc>(context)
                                          .add(UpdateProfileRequestEvent(
                                              userModel: UserModel(
                                                  city: _selectedCity?.name,
                                                  cityId: _selectedCity?.id
                                                      .toString(),
                                                  email: _emailController.text
                                                      .trim(),
                                                  fname: _firstNameController
                                                      .text
                                                      .trim(),
                                                  idcard: state.user.idcard,
                                                  image: _uploadedAvatarLink ??
                                                      state.user.image,
                                                  lname: _lastNameController
                                                      .text
                                                      .trim(),
                                                  mobile: _mobileController.text
                                                      .trim(),
                                                  qrscan: state.user.qrscan,
                                                  shopId: state.user.shopId,
                                                  shopName: state.user.shopName,
                                                  numNotify:
                                                      state.user.numNotify,
                                                  username: _userNameController
                                                      .text
                                                      .trim(),
                                                  password: _passwordController
                                                      .text
                                                      .trim())));
                                    }
                                  }
                                },
                                child: updateState is UpdateProfileLoading
                                    ? MyLoading(
                                        withText: false,
                                        color: Colors.white,
                                      )
                                    : Text('ذخیره'));
                          },
                        )
                      ],
                    ),
                  )
                : state is GetProfileLoading
                    ? MyLoading()
                    : Center(
                        child: Text('حساب کاربری یافت نشد'),
                      );
          },
        ),
      ),
    );
  }

  Padding _menu() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: PopupMenuButton<int>(
        icon: SvgPicture.string(
          MyIcons.menu,
        ),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            onTap: () {},
            value: 0,
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.string(
                  MyIcons.abountUs,
                  width: 20,
                ),
                8.wsb(),
                Text(
                  'درباره ما',
                  style: TextStyle(color: Color(0xff292D32)),
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            onTap: () async {
              await getIt<FlutterSecureStorage>().deleteAll();
              tokenNotifire.value = null;
            },
            value: 1,
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.string(
                  MyIcons.logout,
                  width: 20,
                ),
                8.wsb(),
                Text(
                  'خروج از حساب کاربری',
                  style: TextStyle(color: Color(0xff292D32)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
