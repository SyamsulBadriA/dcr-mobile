import 'package:dcr_mobile/ui/home/check_location_viewmodel.dart';
import 'package:dcr_mobile/widgets/background_pattern.dart';
import 'package:dcr_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class CheckLocationView extends StatelessWidget {
  const CheckLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onDispose: (viewModel) => WidgetsBinding.instance
          .removeObserver(viewModel.lifecycleEventHandler),
      onViewModelReady: (viewModel) {
        viewModel.lifecycleEventHandler.onResumed = (state) {
          if (!viewModel.hasError) {
            viewModel.requestPermission();
          }
        };
        WidgetsBinding.instance.addObserver(viewModel.lifecycleEventHandler);
        WidgetsBinding.instance
            .addPostFrameCallback((_) => viewModel.requestPermission());
      },
      viewModelBuilder: () => CheckLocationViewModel(),
      builder: (context, viewModel, child) {
        if (viewModel.hasError) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: viewModel.modelError,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );

          viewModel.clearErrors();
        }
        return BackgroundPattern(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                viewModel.isBusy
                    ? LoadingAnimationWidget.dotsTriangle(
                        color: Colors.white,
                        size: 80,
                      )
                    : const SizedBox(),
                SizedBox(height: 15.h),
                const Text(
                  "Please, enable your location \nto continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                const Spacer(),
                const Text(
                  "Can't get the permission?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                CustomOutlinedButton(
                  title: "Open Settings",
                  titleColor: Colors.white,
                  outlinedColor: Colors.white,
                  onTap: () async {
                    await openAppSettings();
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  Function(AppLifecycleState)? onResumed;
  final Function(AppLifecycleState)? onPaused;
  final Function(AppLifecycleState)? onInactive;
  final Function(AppLifecycleState)? onDetached;

  LifecycleEventHandler({
    this.onResumed,
    this.onPaused,
    this.onInactive,
    this.onDetached,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (onResumed != null) onResumed!(state);
        break;
      case AppLifecycleState.paused:
        if (onPaused != null) onPaused!(state);
        break;
      case AppLifecycleState.inactive:
        if (onInactive != null) onInactive!(state);
        break;
      case AppLifecycleState.detached:
        if (onDetached != null) onDetached!(state);
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
