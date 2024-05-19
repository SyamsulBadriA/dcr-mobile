import 'package:dcr_mobile/ui/startup_viewmodel.dart';
import 'package:dcr_mobile/widgets/background_pattern.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      onViewModelReady: (viewModel) => WidgetsBinding.instance
          .addPostFrameCallback((_) => viewModel.runStartupLogic()),
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, viewModel, child) {
        if (viewModel.startAnimation == false) {
          viewModel.checkLoggedIn();
        }

        return BackgroundPattern(
          child: Center(
            child: Image.asset(
              "assets/images/logo-detrac-pat.png",
              width: 200,
            ),
          ),
        );
      },
    );
  }
}
