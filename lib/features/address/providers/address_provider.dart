import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/features/address/data/data_source/address_data_source.dart';
import 'package:wssal/features/address/data/models/address_model.dart';

class AddressProvider extends ChangeNotifier {
  final _addressDataSource = AddressDataSource();

  List<Address> _addressList = [];

  List<Address> get addressList => _addressList.reversed.toList();

  bool _loading = false;

  bool get loading => _loading;

  bool _actionLoading = false;

  bool get actionLoading => _actionLoading;
  String? _error;

  String? get error => _error;

  PickResult? _pickResult;

  PickResult? get pickResult => _pickResult;

  void pickMapAddress(PickResult result) {
    _pickResult = result;
    notifyListeners();
  }

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _changeActionLoading(bool val) {
    _actionLoading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  Future<void> getAddresses() async {
    _changeLoading(true);
    _toggleError(null);
    try {
      final addressModel = await _addressDataSource.getAddresses();
      _addressList = addressModel?.addressesList ?? [];
      _changeLoading(false);
    } catch (e) {
      _changeLoading(false);
      _toggleError(e.toString());
    }
  }

  Future<String?> addAddress() async {
    _changeActionLoading(true);
    try {
      final data = {
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
        "address": _pickResult?.formattedAddress,
        "lat": _pickResult?.geometry?.location.lat,
        "lang": _pickResult?.geometry?.location.lng,
      };
      final address = await _addressDataSource.addAddress(data: data);
      if (address != null) {
        _addressList.add(address);
        notifyListeners();
      }
      _changeActionLoading(false);
      return null;
    } catch (e) {
      _changeActionLoading(false);
      return e.toString();
    }
  }

  Future<String?> updateAddress({required String addressId}) async {
    _changeActionLoading(true);
    try {
      final index =
          _addressList.indexWhere((address) => address.id == addressId);
      final data = {
        "id": addressId,
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
        "address": _pickResult?.formattedAddress,
        "lat": _pickResult?.geometry?.location.lat,
        "lang": _pickResult?.geometry?.location.lng,
      };
      final address = await _addressDataSource.updateAddress(data: data);
      if (address != null) {
        _addressList[index] = address;
        notifyListeners();
      }
      _changeActionLoading(false);
      return null;
    } catch (e) {
      _changeActionLoading(false);
      return e.toString();
    }
  }

  Future<bool> deleteAddress({required String addressId}) async {
    _changeActionLoading(true);
    try {
      final res = await _addressDataSource.deleteAddress(addressId: addressId);
      _addressList.removeWhere((address) => address.id == addressId);
      _changeActionLoading(false);
      return res;
    } catch (e) {
      _changeActionLoading(false);
      return false;
    }
  }
}
