import 'package:cloud_firestore/cloud_firestore.dart';

part 'DestinationModel.g.dart';

class DestinationModel{
  final String id;
  final String name;
  final String description;
  final int capacity;
  final Timestamp date;
  final String imageURL;
  final List<dynamic> attendees;
  final String contact;

  DestinationModel(this.id,this.name, this.description, this.capacity, this.date, this.imageURL, this.attendees, this.contact);
  factory DestinationModel.fromJson(Map<String,dynamic>json)
  =>_$DestinationModelFromJson(json);
}