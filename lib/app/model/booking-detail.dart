// To parse this JSON data, do
//
//     final bookingDetail = bookingDetailFromJson(jsonString);

import 'dart:convert';

BookingDetail bookingDetailFromJson(String str) =>
    BookingDetail.fromJson(json.decode(str));

String bookingDetailToJson(BookingDetail data) => json.encode(data.toJson());

class BookingDetail {
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? pickUpTime;
  String? deliveryTime;
  String? discountPrice;
  String? totalPrice;
  String? finalPrice;
  String? bookingStatus;
  CarBookingDetailForStaffDto? carBookingDetailForStaffDto;
  List<GroupServiceBookingDetailDto>? groupServiceBookingDetailDtos;

  BookingDetail(
      {this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.pickUpTime,
      this.deliveryTime,
      this.discountPrice,
      this.totalPrice,
      this.finalPrice,
      this.carBookingDetailForStaffDto,
      this.groupServiceBookingDetailDtos,
      this.bookingStatus});

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        customerAddress: json["customerAddress"],
        pickUpTime: json["pickUpTime"],
        deliveryTime: json["deliveryTime"],
        discountPrice: json["discountPrice"],
        totalPrice: json["totalPrice"],
        finalPrice: json["finalPrice"],
        bookingStatus: json["bookingStatus"],
        carBookingDetailForStaffDto: json["carBookingDetailForStaffDto"] == null
            ? null
            : CarBookingDetailForStaffDto.fromJson(
                json["carBookingDetailForStaffDto"]),
        groupServiceBookingDetailDtos:
            json["groupServiceBookingDetailDtos"] == null
                ? []
                : List<GroupServiceBookingDetailDto>.from(
                    json["groupServiceBookingDetailDtos"]!
                        .map((x) => GroupServiceBookingDetailDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "customerPhone": customerPhone,
        "customerAddress": customerAddress,
        "pickUpTime": pickUpTime,
        "deliveryTime": deliveryTime,
        "discountPrice": discountPrice,
        "totalPrice": totalPrice,
        "finalPrice": finalPrice,
        "bookingStatus": bookingStatus,
        "carBookingDetailForStaffDto": carBookingDetailForStaffDto?.toJson(),
        "groupServiceBookingDetailDtos": groupServiceBookingDetailDtos == null
            ? []
            : List<dynamic>.from(
                groupServiceBookingDetailDtos!.map((x) => x.toJson())),
      };
}

class CarBookingDetailForStaffDto {
  String? carName;
  String? carLicensePlate;

  CarBookingDetailForStaffDto({
    this.carName,
    this.carLicensePlate,
  });

  factory CarBookingDetailForStaffDto.fromJson(Map<String, dynamic> json) =>
      CarBookingDetailForStaffDto(
        carName: json["carName"],
        carLicensePlate: json["carLicensePlate"],
      );

  Map<String, dynamic> toJson() => {
        "carName": carName,
        "carLicensePlate": carLicensePlate,
      };
}

class GroupServiceBookingDetailDto {
  String? serviceGroup;
  List<ServiceListBookingDetailDto>? serviceListBookingDetailDtos;

  GroupServiceBookingDetailDto({
    this.serviceGroup,
    this.serviceListBookingDetailDtos,
  });

  factory GroupServiceBookingDetailDto.fromJson(Map<String, dynamic> json) =>
      GroupServiceBookingDetailDto(
        serviceGroup: json["serviceGroup"],
        serviceListBookingDetailDtos:
            json["serviceListBookingDetailDtos"] == null
                ? []
                : List<ServiceListBookingDetailDto>.from(
                    json["serviceListBookingDetailDtos"]!
                        .map((x) => ServiceListBookingDetailDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "serviceGroup": serviceGroup,
        "serviceListBookingDetailDtos": serviceListBookingDetailDtos == null
            ? []
            : List<dynamic>.from(
                serviceListBookingDetailDtos!.map((x) => x.toJson())),
      };
}

class ServiceListBookingDetailDto {
  String? servicePrice;
  String? serviceName;

  ServiceListBookingDetailDto({
    this.servicePrice,
    this.serviceName,
  });

  factory ServiceListBookingDetailDto.fromJson(Map<String, dynamic> json) =>
      ServiceListBookingDetailDto(
        servicePrice: json["servicePrice"],
        serviceName: json["serviceName"],
      );

  Map<String, dynamic> toJson() => {
        "servicePrice": servicePrice,
        "serviceName": serviceName,
      };
}
