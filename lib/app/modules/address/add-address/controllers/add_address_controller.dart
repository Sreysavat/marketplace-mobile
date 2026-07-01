import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressController extends GetxController{
  Future<void> getCurrentLocation({
    required Function(LatLng) onMoveMap,
    required Function(String) onAddress,
    required Function(LatLng) setPosition,
    required Function(bool) setLoading,
  }) async {
    final pos = await Geolocator.getCurrentPosition();

    final latlng = LatLng(pos.latitude, pos.longitude);

    setPosition(latlng);
    onMoveMap(latlng);

    await updateAddress(
      latlng,
      onAddress: onAddress,
      setLoading: setLoading,
    );
  }

  Future<void> getCurrentLocationButton({
    required Function(LatLng) onMoveMap,
  }) async {
    final pos = await Geolocator.getCurrentPosition();

    final latlng = LatLng(pos.latitude, pos.longitude);

    onMoveMap(latlng);
  }

  Future<void> updateAddress(
      LatLng pos, {
        required Function(String) onAddress,
        required Function(bool) setLoading,
      }) async {
    try {
      setLoading(true);

      final placemarks =
      await placemarkFromCoordinates(pos.latitude, pos.longitude);

      final place = placemarks.first;

      final address = [
        place.street,
        place.subLocality,
        place.locality,
        place.country,
      ].where((e) => e != null && e.isNotEmpty).join(", ");

      onAddress(address);
    } finally {
      setLoading(false);
    }
  }
}