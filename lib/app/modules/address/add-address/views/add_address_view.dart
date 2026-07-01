import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:marketplace_app/app/modules/address/add-address/controllers/add_address_controller.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final controller = Get.put(AddAddressController());

  GoogleMapController? mapController;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  LatLng currentPosition = const LatLng(11.562108, 104.888535);

  bool loadingAddress = false;

  final String googleApiKey = "YOUR_GOOGLE_MAPS_API_KEY";

  @override
  void initState() {
    super.initState();
    controller.getCurrentLocation(
      onMoveMap: (pos) {
        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(pos, 17),
        );
      },
      onAddress: (addr) {
        addressController.text = addr;
      },
      setPosition: (pos) {
        setState(() => currentPosition = pos);
      },
      setLoading: (v) {
        setState(() => loadingAddress = v);
      },
    );
  }

  // ================= SEARCH =================
  Future<List<dynamic>> searchPlaces(String query) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$googleApiKey";

    final res = await http.get(Uri.parse(url));
    return jsonDecode(res.body)["predictions"];
  }

  Future<LatLng> getPlaceLatLng(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";

    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body);

    final loc = data["result"]["geometry"]["location"];

    return LatLng(loc["lat"], loc["lng"]);
  }

  void openSearch() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search location",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: searchPlaces(searchController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("Search location"));
                    }

                    final results = snapshot.data as List;

                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, i) {
                        final item = results[i];

                        return ListTile(
                          title: Text(item["description"]),
                          onTap: () async {
                            final latlng =
                            await getPlaceLatLng(item["place_id"]);

                            setState(() => currentPosition = latlng);

                            mapController?.animateCamera(
                              CameraUpdate.newLatLngZoom(latlng, 17),
                            );

                            Navigator.pop(context);

                            await controller.updateAddress(
                              latlng,
                              onAddress: (addr) {
                                addressController.text = addr;
                              },
                              setLoading: (v) {
                                setState(() => loadingAddress = v);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onCameraMove(CameraPosition pos) {
    currentPosition = pos.target;
  }

  Future<void> onCameraIdle() async {
    await controller.updateAddress(
      currentPosition,
      onAddress: (addr) {
        addressController.text = addr;
      },
      setLoading: (v) {
        setState(() => loadingAddress = v);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Address"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: openSearch,
          )
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentPosition,
                    zoom: 15,
                  ),
                  onMapCreated: (c) => mapController = c,
                  onCameraMove: onCameraMove,
                  onCameraIdle: onCameraIdle,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),

                const Center(
                  child: Icon(
                    Icons.location_pin,
                    size: 45,
                    color: Colors.red,
                  ),
                ),

                if (loadingAddress)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: addressController,
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              controller.getCurrentLocationButton(
                onMoveMap: (pos) {
                  setState(() {
                    currentPosition = pos;
                  });

                  mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(pos, 17),
                  );
                },
              );
            },
            child: const Text("Use my current location"),
          )
        ],
      ),
    );
  }
}