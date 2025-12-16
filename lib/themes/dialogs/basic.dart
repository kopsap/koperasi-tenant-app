import "package:flutter/material.dart";

Dialog dialogTemplate({component, width = 400.0, height = 200.0}) => Dialog(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: Container(
    height: height,
    width: width,
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    child: component
  ),
);
