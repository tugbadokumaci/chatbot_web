// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openAPIModel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenApiModel _$OpenApiModelFromJson(Map<String, dynamic> json) => OpenApiModel(
      id: json['id'] as String,
      root: json['root'] as String,
      created: (json['created'] as num).toInt(),
    );

Map<String, dynamic> _$OpenApiModelToJson(OpenApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'root': instance.root,
    };
