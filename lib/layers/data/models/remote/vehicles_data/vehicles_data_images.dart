import 'package:json_annotation/json_annotation.dart';

part 'vehicles_data_images.g.dart';

@JsonSerializable()
class VehiclesDataImages {
  @JsonKey(name: 'big_icon')
  final String bigIcon;

  VehiclesDataImages({
    required this.bigIcon,
  });

  factory VehiclesDataImages.fromJson(Map<String, dynamic> json) =>
      _$VehiclesDataImagesFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDataImagesToJson(this);
}
