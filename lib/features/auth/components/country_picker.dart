import 'dart:convert';
import 'package:finkart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../utils/country_model.dart';
import '../../shared/colors/colors.dart';

class CountryPicker extends StatefulWidget {
  final TextEditingController country;
  final VoidCallback onTap;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginAll;
  final IsValid isValid;

  const CountryPicker({
    super.key,
    required this.country,
    this.marginTop = 10.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.marginAll = 0.0,
    required this.onTap,
    this.isValid = IsValid.none,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  List<CountryModel> _countryList = [];
  FocusNode _focusNode = FocusNode();
  final Color _validBorderColor = primaryColor;
  final Color _notValidBorderColor = doesNotMatchError;
  final Color _focusBorderColor = lightGreyColor;
  var _isFocused = false;
  List<CountryModel> _countrySubList = [];
  String _title = '';

  @override
  void initState() {
    super.initState();
    _getCountry();

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

  Future<void> _getCountry() async {
    _countryList.clear();
    var jsonString = await rootBundle.loadString('assets/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList =
          body.map((dynamic item) => CountryModel.fromJson(item)).toList();
      _countrySubList = _countryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Country TextField
        Container(
          height: authContainerHeight,
          padding: const EdgeInsets.fromLTRB(12, 1.5, 4, 1.5),
          decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(
                  color: widget.isValid == IsValid.none
                      ? _isFocused
                          ? _focusBorderColor
                          : Colors.transparent
                      : widget.isValid == IsValid.valid
                          ? _validBorderColor
                          : _notValidBorderColor),
              borderRadius: BorderRadius.circular(8.0)),
          margin: widget.marginAll > 0
              ? EdgeInsets.all(widget.marginAll)
              : EdgeInsets.only(
                  top: widget.marginTop,
                  left: widget.marginLeft,
                  right: widget.marginRight,
                  bottom: widget.marginBottom),
          child: TextField(
            controller: widget.country,
            onTap: () {
              setState(() => _title = 'Country of Origin');
              _showDialog(context);
            },
            decoration: const InputDecoration(
                isDense: true,
                suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                labelStyle:
                    TextStyle(color: textColor, fontWeight: FontWeight.w400),
                labelText: "Country of origin",
                border: InputBorder.none
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                ),
            readOnly: true,
            focusNode: _focusNode,
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(_title,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),

                      ///Text Field
                      TextField(
                        controller: controller,
                        onChanged: (val) {
                          setState(() {
                            _countrySubList = _countryList
                                .where((element) => element.name
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()))
                                .toList();
                          });
                        },
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16.0),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            isDense: true,
                            prefixIcon: Icon(Icons.search)),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          itemCount: _countrySubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                widget.onTap();
                                setState(() {
                                  widget.country.text =
                                      _countrySubList[index].name;
                                  _countrySubList = _countryList;
                                });
                                controller.clear();
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 10.0, right: 10.0),
                                child: Text(_countrySubList[index].name,
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 16.0)),
                              ),
                            );
                          },
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () {
                          _countrySubList = _countryList;

                          controller.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16.0))));
  }

  InputDecoration defaultDecoration = const InputDecoration(
      isDense: true,
      hintText: 'Select',
      suffixIcon: Icon(Icons.arrow_drop_down),
      border: OutlineInputBorder());
}
