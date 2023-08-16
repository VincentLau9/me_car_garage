// To parse this JSON data, do
//
//     final bookingOverall = bookingOverallFromJson(jsonString);

import 'dart:convert';

BookingOverall bookingOverallFromJson(String str) =>
    BookingOverall.fromJson(json.decode(str));

String bookingOverallToJson(BookingOverall data) => json.encode(data.toJson());

class BookingOverall {
  String? hour;
  List<BookingListForStaffResponseDto>? bookingListForStaffResponseDtos;

  BookingOverall({
    this.hour,
    this.bookingListForStaffResponseDtos,
  });

  factory BookingOverall.fromJson(Map<String, dynamic> json) => BookingOverall(
        hour: json["hour"],
        bookingListForStaffResponseDtos:
            json["bookingListForStaffResponseDtos"] == null
                ? []
                : List<BookingListForStaffResponseDto>.from(
                    json["bookingListForStaffResponseDtos"]!.map(
                        (x) => BookingListForStaffResponseDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "bookingListForStaffResponseDtos":
            bookingListForStaffResponseDtos == null
                ? []
                : List<dynamic>.from(
                    bookingListForStaffResponseDtos!.map((x) => x.toJson())),
      };
}

class BookingListForStaffResponseDto {
  int? bookingId;
  String? carName;
  String? customerName;
  String? bookingDuration;

  BookingListForStaffResponseDto(
      {this.carName, this.customerName, this.bookingDuration, this.bookingId});

  factory BookingListForStaffResponseDto.fromJson(Map<String, dynamic> json) =>
      BookingListForStaffResponseDto(
        bookingId: json["bookingId"],
        carName: json["carName"],
        customerName: json["customerName"],
        bookingDuration: json["bookingDuration"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "carName": carName,
        "customerName": customerName,
        "bookingDuration": bookingDuration,
      };
}
