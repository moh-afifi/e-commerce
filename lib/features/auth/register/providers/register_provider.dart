import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/providers/user_provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/features/auth/register/data/data_source/register_data_source.dart';
import 'package:wssal/features/auth/register/data/models/entity_model.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
// ignore_for_file: use_build_context_synchronously
class RegisterProvider extends ChangeNotifier {
  RegisterProvider() {
    getRegions();
    getEntityType();
  }

  final _registerDataSource = RegisterDataSource();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  PageController pageController = PageController();

  int index = 0;
  XFile? image;

  Entity? _chosenArea;

  Entity? get chosenArea => _chosenArea;

  Entity? _chosenPlaceType;

  Entity? get chosenPlaceType => _chosenPlaceType;

  bool _loading = false;

  bool get loading => _loading;

  bool _placeLoading = false;

  bool get placeLoading => _placeLoading;

  String? _placeError;

  String? get placeError => _placeError;

  bool _typeLoading = false;

  bool get typeLoading => _typeLoading;

  String? _typeError;

  String? get typeError => _typeError;

  PickResult? _pickResult;

  PickResult? get pickResult => _pickResult;
  bool showPassword = false;
  List<Entity> _areaList = [];

  List<Entity> get areaList => _areaList;

  List<Entity> _typeList = [];

  List<Entity> get typeList => _typeList;

  Future<void> pickFile() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void showHidePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void changeIndex(int val) {
    index = val;
    notifyListeners();
  }

  void _changePlaceError(String? error) {
    _placeError = error;
    notifyListeners();
  }

  void changeMapAddress(PickResult result) {
    _pickResult = result;
    notifyListeners();
  }

  void _changePlaceLoading(bool val) {
    _placeLoading = val;
    notifyListeners();
  }

  void _changeTypeError(String? error) {
    _typeError = error;
    notifyListeners();
  }

  void _changeTypeLoading(bool val) {
    _typeLoading = val;
    notifyListeners();
  }

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void changeArea(Entity? val) {
    _chosenArea = val;
    notifyListeners();
  }

  void changePlaceType(Entity? val) {
    _chosenPlaceType = val;
    notifyListeners();
  }

  void removeFile() {
    image = null;
    notifyListeners();
  }

  Future<String?> register(BuildContext context) async {
    _changeLoading(true);
    try {
      final filePath = image?.path ?? '';
      final multiPartFile = MultipartFile.fromFileSync(
        filePath,
        filename: image?.name,
      );
      final user = await _registerDataSource.register(
        body: {
          "mobile_no": phoneController.text,
          "pwd": passwordController.text,
          "name": nameController.text,
          "facility_name": placeNameController.text,
          "facility_type": _chosenPlaceType?.value,
          "region": _chosenArea?.value,
          "address": locationController.text,
          "lat": pickResult?.geometry?.location.lat.toString(),
          "lang": pickResult?.geometry?.location.lng.toString(),
          "file": multiPartFile,
          "device_token": GetIt.instance<SharedPreferences>().getString(Constants.deviceToken)
        },
      );
      await AppUtils.cacheUserData(user);
      context.read<UserProvider>().getUser();
      context.read<CartProvider>().clearCart();
      context.read<FavoriteProvider>().clearFavorites();
      _changeLoading(false);
      return null;
    } catch (e) {
      _changeLoading(false);
      return e.toString();
    } finally {
      changeIndex(0);
    }
  }

  Future<void> getRegions() async {
    try {
      _changePlaceLoading(true);
      _changePlaceError(null);
      final response = await _registerDataSource.getRegions();
      _areaList = response?.entitiesList ?? [];
      _chosenArea = null;
      notifyListeners();
      _changePlaceLoading(false);
    } catch (e) {
      _changePlaceLoading(false);
      _changePlaceError(e.toString());
    }
  }

  Future<void> getEntityType() async {
    try {
      _changeTypeLoading(true);
      _changeTypeError(null);
      final response = await _registerDataSource.getEntityType();
      _chosenPlaceType = null;
      _typeList = response?.entitiesList ?? [];
      _chosenArea = null;
      notifyListeners();
      _changeTypeLoading(false);
    } catch (e) {
      _changeTypeLoading(false);
      _changeTypeError(e.toString());
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    placeNameController.dispose();
    locationController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
