import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

enum Type { phone, email, name, password, confirmPassword }

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {super.key,
      this.labelText,
      required this.controller,
      this.marginTop = 10.0,
      this.marginBottom = 0.0,
      this.marginLeft = 0.0,
      this.marginRight = 0.0,
      this.marginAll = 0.0,
      required this.onChanged,
      this.type = Type.name,
      this.isValid = IsValid.none,
      this.enabled = true,
      this.hintText});
  final String? labelText;
  final String? hintText;

  final TextEditingController controller;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginAll;
  final ValueChanged<String>? onChanged;
  final IsValid isValid;
  final Type type;
  final bool enabled;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final FocusNode _focusNode = FocusNode();
  final Color _validBorderColor = primaryColor;
  final Color _notValidBorderColor = doesNotMatchError;
  final Color _focusBorderColor = lightGreyColor;
  var _isFocused = false;

  bool _hideText = true;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.isValid == IsValid.none) {
        setState(() {
          if (_focusNode.hasFocus) {
            _isFocused = true;
          } else {
            _isFocused = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(17, 1.5, 4, 1.5),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              color: Color(0x25000000),
              blurRadius: 4.16,
              offset: Offset(0, 4.16),
            ),
          ],
          color: whiteColor,
          // border: Border.all(
          //     color: widget.isValid == IsValid.none
          //         ? _isFocused
          //             ? _focusBorderColor
          //             : Colors.transparent
          //         : widget.isValid == IsValid.valid
          //             ? _validBorderColor
          //             : _notValidBorderColor),
          borderRadius: BorderRadius.circular(31.0)),
      margin: widget.marginAll > 0
          ? EdgeInsets.all(widget.marginAll)
          : EdgeInsets.only(
              top: widget.marginTop,
              left: widget.marginLeft,
              right: widget.marginRight,
              bottom: widget.marginBottom),
      child: TextFormField(
        enabled: widget.enabled,
        obscuringCharacter: '*',
        cursorColor: textColor,
        cursorHeight: 19,
        keyboardType: widget.type == Type.phone
            ? TextInputType.number
            : TextInputType.text,
        onChanged: (text) {
          widget.onChanged!(text);
        },
        focusNode: _focusNode,
        controller: widget.controller,
        style: const TextStyle(
            color: textColor, fontSize: 16.0, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            icon: Transform.scale(
              scaleX: -1,
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                height: 20.0,
                width: 20.0,
              ),
            ),
            isDense: false,
            suffixIcon: widget.type == Type.password ||
                    widget.type == Type.confirmPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _hideText = !_hideText;
                      });
                    },
                    icon: Transform.scale(
                      alignment: Alignment.center,
                      scaleX: -1,
                      child: Icon(
                        _hideText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                    ))
                : null,
            labelStyle:
                const TextStyle(color: textColor, fontWeight: FontWeight.w400),
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle:
                const TextStyle(color: textColor, fontWeight: FontWeight.w400),
            border: InputBorder.none),
      ),
    );
  }
}
