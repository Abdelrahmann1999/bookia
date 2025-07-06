import 'dart:io';

import 'package:dio/dio.dart';

class EditProfileParams {
  String? name;
  String? address;
  String? phone;
  File? image;

  EditProfileParams({this.name, this.address, this.phone, this.image});

  factory EditProfileParams.fromJson(Map<String, dynamic> json) {
    return EditProfileParams(
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
     
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'phone': phone,
  };

 Future<FormData> toFormData() async {
  final formadata = <String, dynamic>{};

  if (name != null) {
    formadata['name'] = name;
  }
  if (address != null) {
    formadata['address'] = address;
  }
  if (phone != null) {
    formadata['phone'] = phone;
  }
  if (image != null) {
    formadata['image'] = await MultipartFile.fromFile(
      image!.path,
      filename: image!.path.split('/').last,
    );
  }

  return FormData.fromMap(formadata);
}

}
