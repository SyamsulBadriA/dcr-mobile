import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatefulWidget {
  final FocusNode? curFocusNode;
  final FocusNode? nextFocusNode;
  final String? hint;
  final String? label;
  final Function(String)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? obscureText;
  final int? minLine;
  final int? maxLine;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatter;
  final bool? isHintVisible;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final String? semantic;
  final Color? fillColor;
  final Color? outlinedColor;
  final Color? labelColor;
  final String? labelText;
  final Color? hintColor;
  final Color? cursorColor;
  final String? initialValue;
  final bool isLabelIncluded;
  final bool isRequired;

  const CustomTextInput({
    super.key,
    this.suffixIcon,
    this.curFocusNode,
    this.nextFocusNode,
    this.hint,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.obscureText,
    this.minLine,
    this.maxLine,
    this.textAlign,
    this.enable,
    this.inputFormatter,
    this.isHintVisible,
    this.prefixIcon,
    this.prefixText,
    this.hintText,
    this.autofillHints,
    this.semantic,
    this.label,
    this.fillColor,
    this.outlinedColor,
    this.labelColor,
    this.labelText,
    this.hintColor,
    this.cursorColor,
    this.initialValue,
    this.isLabelIncluded = false,
    this.isRequired = false,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isLabelIncluded
            ? Row(
                children: [
                  Text(widget.label ?? ''),
                  widget.isRequired
                      ? const SizedBox(width: 5)
                      : const SizedBox.shrink(),
                  widget.isRequired
                      ? const Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : const SizedBox.shrink(),
        widget.isLabelIncluded
            ? const SizedBox(height: 10)
            : const SizedBox.shrink(),
        TextFormField(
          initialValue: widget.initialValue,
          key: widget.key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: widget.autofillHints,
          enabled: widget.enable,
          obscureText: widget.obscureText ?? false,
          focusNode: widget.curFocusNode,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          textAlign: widget.textAlign ?? TextAlign.start,
          minLines: widget.obscureText == true ? null : widget.minLine ?? 1,
          maxLines: widget.maxLine ?? 1,
          inputFormatters: widget.inputFormatter,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: widget.cursorColor,
          decoration: InputDecoration(
            // label: Text(widget.label ?? ''),
            labelText: widget.label,
            filled: true,
            fillColor: widget.fillColor ?? Colors.transparent,
            labelStyle: TextStyle(
              color: widget.labelColor ?? Colors.black26,
            ),
            prefixText: widget.prefixText,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: widget.hintColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: widget.suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 2,
                color: widget.outlinedColor ??
                    Theme.of(context).colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: widget.outlinedColor ?? Colors.black12,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: widget.outlinedColor ?? Colors.black12,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: widget.outlinedColor ?? Colors.red,
              ),
            ),
          ),
          validator: widget.validator as String? Function(String?)?,
          onChanged: widget.onChanged,
          onTap: widget.onTap as void Function()?,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
