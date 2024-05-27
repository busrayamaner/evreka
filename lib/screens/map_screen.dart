import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evreka/controllers/map_controller.dart';
import 'package:evreka/globals/text_styles.dart';
import 'package:evreka/widgets/buttons/button.dart';
import 'package:evreka/widgets/containers/marker_container.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('containers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            controller.addAllMarkers(snapshot);
            return Obx(() => GoogleMap(
                  initialCameraPosition: controller.kGooglePlex,
                  onMapCreated: controller.onMapCreated,
                  markers: Set<Marker>.of(controller.markers),
                  onTap: controller.isChangeLocation.value &&
                          controller.selectedMarker.value != null
                      ? controller.onMapTapped
                      : null,
                ));
          },
        ),
        bottomNavigationBar: Obx(() => controller.selectedMarker.value != null
            ? controller.isChangeLocation.value == true
                ? changeLocationContainer()
                : selectedMarkerContainer()
            : Container()));
  }

  Widget changeLocationContainer() {
    return MarkerContainer(
      height: 20.h,
      child: Column(
        children: [
          Text(
            "Please select a location from the map for your bin to be relovated. You can select a location by tapping on the map",
            style: EvrekaTextStyles.t1,
          ),
          SizedBox(
            height: 3.h,
          ),
          EvrekaButton(
              text: "SAVE",
              buttonEnable: true,
              func: () {
                controller.updateMarkerLocation();
              })
        ],
      ),
    );
  }

  Widget selectedMarkerContainer() {
    return MarkerContainer(
      height: 32.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Container ${controller.selectedMarker.value!.markerId.value}",
            style: EvrekaTextStyles.h3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Next Collection",
            style: EvrekaTextStyles.h4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            controller.selectedMarker.value!.infoWindow.title!,
            style: EvrekaTextStyles.t1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Fullness Rate",
            style: EvrekaTextStyles.h4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "% ${controller.selectedMarker.value!.infoWindow.snippet}",
            style: EvrekaTextStyles.t1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              Expanded(
                  child: EvrekaButton(
                      text: "NAVIGATE",
                      buttonEnable: true,
                      func: () {
                        controller.selectedMarker.value = null;
                      })),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                  child: EvrekaButton(
                      text: "RELOCATE",
                      buttonEnable: true,
                      func: () {
                        controller.isChangeLocation.value = true;
                      })),
            ],
          )
        ],
      ),
    );
  }
}
