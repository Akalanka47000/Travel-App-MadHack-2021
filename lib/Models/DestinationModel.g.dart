

part of 'DestinationModel.dart';

DestinationModel _$DestinationModelFromJson(Map<String, dynamic> json) {
  return DestinationModel(
    json["id"] as String,
    json["name"] as String,
    json["description"] as String,
    json["capacity"] as int,
    json["date"] as Timestamp,
    json["imageURL"] as String,
    json["attendees"] as List<dynamic>,
    json["contact"] as String,
    json["location"] as GeoPoint,

  );
}

Map<String, dynamic> _$DestinationModelToJson(DestinationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'capacity': instance.capacity,
      'date': instance.date,
      'imageURL': instance.imageURL,
      'attendees': instance.attendees,
      'contact': instance.contact,
      'location': instance.location,
    };
