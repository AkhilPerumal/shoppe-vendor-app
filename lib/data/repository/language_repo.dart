import 'package:carclenx_vendor_app/data/model/response/language_model.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
