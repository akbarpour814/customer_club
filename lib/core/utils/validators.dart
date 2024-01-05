import 'package:customer_club/core/utils/extentions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

String? nationalCodeValidator(String? value) {
  if (value == null ||
      value.trim().isEmpty ||
      value.trim().length != 10 ||
      !value.trim().toEnglishDigit().isValidIranianNationalCode()) {
    return 'لطفا کد ملی را به درستی وارد نمایید';
  } else {
    return null;
  }
}

String? postalCodeValidator(String? value) {
  if (value != null && value.isNotEmpty) {
    if (value.length != 10 || (value.contains('0') && (value.contains('2')))) {
      return 'لطفا کد پستی را به درستی وارد نمایید';
    } else {
      return null;
    }
  } else {
    return null;
  }
}

String? emailValidator(String? value) {
  if (value != null && value.isNotEmpty) {
    if (!value.isNotNullOrEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'لطفا ایمیل را به درستی وارد نمایید';
    } else {
      return null;
    }
  } else {
    return null;
  }
}

String? mobileNumberValidator(String? value) {
  if (value == null ||
      value.trim().isEmpty ||
      !value.trim().toEnglishDigit().isValidIranianMobileNumber()) {
    return 'لطفا شماره موبایل را به درستی وارد نمایید';
  } else {
    return null;
  }
}

String? phoneNumberValidator(String? value, {bool isRequired = false}) {
  if (isRequired) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length != 11 ||
        !value.trim().toEnglishDigit().isValidIranianMobileNumber()) {
      return 'لطفا شماره تلفن را به درستی وارد نمایید';
    } else {
      return null;
    }
  } else {
    if (value != null && value.isNotEmpty) {
      if (value.trim().length != 11 ||
          !value.trim().toEnglishDigit().isValidIranianMobileNumber()) {
        return 'لطفا شماره تلفن را به درستی وارد نمایید';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

String? generalValidator(String? value, String title) {
  if (value == null || value.trim().isEmpty) {
    return 'لطفا $title را به درستی وارد نمایید';
  }
  return null;
}

String? latinValidator(String? value, String title) {
  if (value == null ||
      value.trim().isEmpty ||
      !RegExp(r'^\S.*[a-zA-Z\s]*$').hasMatch(value)) {
    return 'لطفا $title را به درستی وارد نمایید';
  }
  return null;
}

String? smsCodeValidator(String? value) {
  if (value == null || value.trim().isEmpty || value.trim().length != 5) {
    return 'کد به درستی وارد نشده است';
  } else {
    return null;
  }
}

String? dropdownValidator(Object? value, String title) {
  if (value == null) {
    return 'لطفا $title را انتخاب نمایید';
  }
  return null;
}

String? cardValidator(Object? value) {
  if (value.toString().replaceAll('-', '').startsWith('502908')) {
    return 'امکان افزودن کارت بانک توسعه تعاون وجود ندارد';
  }
  if (value == null ||
      !value.toString().replaceAll('-', '').isValidBankCardNumber()) {
    return 'شماره کارت وارد شده صحیح نمی‌باشد';
  }
  return null;
}
