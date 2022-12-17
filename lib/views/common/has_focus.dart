import 'package:flutter/material.dart';

bool hasFocus({
  required List<FocusNode> nodes,
}){
  int count = 0;
  for (FocusNode node in nodes) {
    if( !node.hasFocus ){
      count++;
    }
  }
  if( count == nodes.length ){
    return false;
  }else{
    return true;
  }
}