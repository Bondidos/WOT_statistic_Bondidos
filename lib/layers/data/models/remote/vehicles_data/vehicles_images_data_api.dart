import 'package:json_annotation/json_annotation.dart';

part 'vehicles_images_data_api.g.dart';

@JsonSerializable()
class VehiclesImagesDataApi {
  @JsonKey(name: 'big_icon')
  final String bigIcon;

  VehiclesImagesDataApi({
    required this.bigIcon,
  });

  factory VehiclesImagesDataApi.fromJson(Map<String, dynamic> json) =>
      _$VehiclesImagesDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesImagesDataApiToJson(this);
}
