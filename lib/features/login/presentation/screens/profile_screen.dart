import 'dart:io';

import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/image_picker.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/core/widgets/my_icon_button.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/login/presentation/blocs/get_profile/get_profile_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProfileBloc()..add(GetProfileStartEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: SvgPicture.string(MyIcons.profileWhite)),
          title: const Text(
            'حساب کاربری',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: MyIconButton(
                  onTap: () async {
                    await getIt<FlutterSecureStorage>().deleteAll();
                    tokenNotifire.value = null;
                  },
                  child: RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.string(MyIcons.logout))),
            )
          ],
          centerTitle: true,
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: BlocConsumer<GetProfileBloc, GetProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state is GetProfileLoaded
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 24),
                              child: Card(
                                borderOnForeground: false,
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                color: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTapDown: (details) {
                                    // if (state is! UpdateProfileBloc) {
                                    imagePicker(context, details,
                                        isAlreadyPicked: _pickedImage != null,
                                        onPick: (file) {
                                      setState(() {
                                        _pickedImage = file;
                                      });
                                    });
                                    // }
                                  },
                                  child: _pickedImage != null
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                      FileImage(_pickedImage!)),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                        )
                                      : state.user.image.isNotNullOrEmpty
                                          ? Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                      image: NetworkImage(state.user.image!))),
                                            )
                                          : 100.whsb(
                                              child: SvgPicture.string(MyIcons.avatar),
                                            ),
                                ),
                              )),
                        ],
                      ),
                    ],
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
}
