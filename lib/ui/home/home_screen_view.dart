import 'package:dcr_mobile/ui/home/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Detrac Viewer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            bottomOpacity: 0.5,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset("assets/images/support-agent.svg"),
              )
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.terrain,
              initialCameraPosition: viewModel.cameraPosition,
              polylines: <Polyline>{viewModel.polyline},
              markers: Set<Marker>.of(viewModel.checkpointsMarker),
              onMapCreated: (controller) =>
                  viewModel.controller.complete(controller),
            ),
          ),
        );
      },
    );
  }
}
