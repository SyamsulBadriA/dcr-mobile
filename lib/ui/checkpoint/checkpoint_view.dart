import 'package:dcr_mobile/ui/checkpoint/chckpoint_viewmodel.dart';
import 'package:dcr_mobile/widgets/background_pattern.dart';
import 'package:dcr_mobile/widgets/button_primary.dart';
import 'package:dcr_mobile/widgets/custome_textinput_committee.dart';
import 'package:dcr_mobile/widgets/DropdownMenuExample.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckPointView extends StatefulWidget {
  const CheckPointView({super.key});

  @override
  State<CheckPointView> createState() => _CheckPointViewState();
}

class _CheckPointViewState extends State<CheckPointView> {
  String dropdownValue = '10';
  final TextEditingController _controller = TextEditingController(text: '10| ');

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkInput);
  }

  void _checkInput() {
    if (!_controller.text.startsWith('$dropdownValue| ')) {
      _controller.text = '$dropdownValue| ';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_checkInput);
    _controller.dispose();
    super.dispose();
  }

  void _updateTextInput(String value) {
    setState(() {
      dropdownValue = value;
      _controller.text = '$value| ';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckPointViewModel>.reactive(
      viewModelBuilder: () => CheckPointViewModel(),
      builder: (context, viewModel, child) => BackgroundPattern(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo-white.png",
                  width: 250,
                ),
                const Text(
                  "Check Point",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                DropdownMenuExample(
                  dropdownValue: dropdownValue,
                  onChanged: _updateTextInput,
                ),
                const SizedBox(height: 30),
                TextInputComite(controller: _controller),
                const SizedBox(height: 30),
                ButtonPrimary(
                  title: "Submit",
                  onTap: () => viewModel.submitCheckpointUserLocation(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
