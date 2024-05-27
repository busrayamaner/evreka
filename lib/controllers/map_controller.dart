import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evreka/globals/assets.dart';
import 'package:evreka/models/container_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MapController extends GetxController {
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  RxList<Marker> markers = <Marker>[].obs;
  Rx<Marker?> selectedMarker = Rx(null);
  RxBool isChangeLocation = false.obs;
  Marker? newLocationMarker;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(39.137983408586855, 32.388855274896464),
    zoom: 14.4746,
  );

  @override
  void onInit() {
    loadMarkers();
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    loadMarkers();
  }

  void loadMarkers() {
    FirebaseFirestore.instance
        .collection('containers')
        .snapshots()
        .listen((snapshot) async {
      markers.clear();
      final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        EvrekaAssets.greenMarker,
      );
      for (var doc in snapshot.docs) {
        final ContainerModel container = ContainerModel.fromJson(doc.data());
        final marker = Marker(
          onTap: () {
            onMarkerTapped(doc.id);
          },
          markerId: MarkerId(doc.id),
          icon: icon,
          position: LatLng(container.latitude, container.longitude),
          infoWindow: InfoWindow(
              title:
                  DateFormat('dd.MM.yyyy').format(container.lastReceivedDate),
              snippet: container.fullness.toString()),
        );
        markers.add(marker);
      }
    });
  }

  Future<void> updateMarkerLocation() async {
    CollectionReference markers =
        FirebaseFirestore.instance.collection('containers');
    DocumentReference markerRef =
        markers.doc(selectedMarker.value!.markerId.value);
    await markerRef.update({
      'latitude': newLocationMarker!.position.latitude,
      'longitude': newLocationMarker!.position.longitude,
    });

    selectedMarker.value = null;
    isChangeLocation.value = false;
  }

  void onMapTapped(LatLng location) async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      EvrekaAssets.yellowMarker,
    );
    newLocationMarker = Marker(
      markerId: const MarkerId('newLocation'),
      position: location,
      icon: icon,
    );
    markers.add(newLocationMarker!);
  }

  void onMarkerTapped(String markerId) {
    markers.remove(newLocationMarker);
    isChangeLocation.value = false;
    selectedMarker.value =
        markers.firstWhere((marker) => marker.markerId.value == markerId);
  }

  void addAllMarkers(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    markers.clear();
    for (var doc in snapshot.data!.docs) {
      final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      final ContainerModel container = ContainerModel.fromJson(data!);
      final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        EvrekaAssets.greenMarker,
      );
      final marker = Marker(
        onTap: () {
          onMarkerTapped(doc.id);
        },
        markerId: MarkerId(doc.id),
        position: LatLng(container.latitude, container.longitude),
        icon: icon,
        infoWindow: InfoWindow(
          title: DateFormat('dd.MM.yyyy').format(container.lastReceivedDate),
          snippet: container.fullness.toString(),
        ),
      );
      markers.add(marker);
    }
  }
}
