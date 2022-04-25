import 'package:json_annotation/json_annotation.dart';

part 'vehicle_images.g.dart';

@JsonSerializable()
class VehicleImages {
  @JsonKey(name: 'big_icon')
  final String bigIcon;

  VehicleImages({
    required this.bigIcon,
  });

  factory VehicleImages.fromJson(Map<String, dynamic> json) =>
      _$VehicleImagesFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleImagesToJson(this);
}
