// To parse this JSON data, do
//
//     final bookingOverallDetail = bookingOverallDetailFromJson(jsonString);

import 'dart:convert';

BookingOverallDetail bookingOverallDetailFromJson(String str) => BookingOverallDetail.fromJson(json.decode(str));

String bookingOverallDetailToJson(BookingOverallDetail data) => json.encode(data.toJson());

class BookingOverallDetail {
    String? carName;
    String? duration;
    String? bookingDay;
    String? customerName;
    String? customerImage;
    List<MechanicServiceStatusForStaffDto>? mechanicServiceStatusForStaffDtos;
    List<ServiceStatusForStaffDto>? serviceStatusForStaffDtos;

    BookingOverallDetail({
        this.carName,
        this.duration,
        this.bookingDay,
        this.customerName,
        this.customerImage,
        this.mechanicServiceStatusForStaffDtos,
        this.serviceStatusForStaffDtos,
    });

    factory BookingOverallDetail.fromJson(Map<String, dynamic> json) => BookingOverallDetail(
        carName: json["carName"],
        duration: json["duration"],
        bookingDay: json["bookingDay"],
        customerName: json["customerName"],
        customerImage: json["customerImage"]??"",
        mechanicServiceStatusForStaffDtos: json["mechanicServiceStatusForStaffDtos"] == null ? [] : List<MechanicServiceStatusForStaffDto>.from(json["mechanicServiceStatusForStaffDtos"]!.map((x) => MechanicServiceStatusForStaffDto.fromJson(x))),
        serviceStatusForStaffDtos: json["serviceStatusForStaffDtos"] == null ? [] : List<ServiceStatusForStaffDto>.from(json["serviceStatusForStaffDtos"]!.map((x) => ServiceStatusForStaffDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "carName": carName,
        "duration": duration,
        "bookingDay": bookingDay,
        "customerName": customerName,
        "customerImage": customerImage,
        "mechanicServiceStatusForStaffDtos": mechanicServiceStatusForStaffDtos == null ? [] : List<ServiceStatusForStaffDto>.from(mechanicServiceStatusForStaffDtos!.map((x) => x.toJson())),
        "serviceStatusForStaffDtos": serviceStatusForStaffDtos == null ? [] : List<ServiceStatusForStaffDto>.from(serviceStatusForStaffDtos!.map((x) => x.toJson())),
    };
}

class MechanicServiceStatusForStaffDto {
    String? mechanicName;
    bool? isMainMechanic;
    String? mechanicImage;

    MechanicServiceStatusForStaffDto({
        this.mechanicName,
        this.isMainMechanic,
        this.mechanicImage,
    });

    factory MechanicServiceStatusForStaffDto.fromJson(Map<String, dynamic> json) => MechanicServiceStatusForStaffDto(
        mechanicName: json["mechanicName"],
        isMainMechanic: json["isMainMechanic"],
        mechanicImage: json["mechanicImage"],
    );

    Map<String, dynamic> toJson() => {
        "mechanicName": mechanicName,
        "isMainMechanic": isMainMechanic,
        "mechanicImage": mechanicImage,
    };
}

class ServiceStatusForStaffDto {
    int? bookingDetailId;
    String? serviceName;
    String? bookingServiceStatus;

    ServiceStatusForStaffDto({
        this.bookingDetailId,
        this.serviceName,
        this.bookingServiceStatus,
    });

    factory ServiceStatusForStaffDto.fromJson(Map<String, dynamic> json) => ServiceStatusForStaffDto(
        bookingDetailId: json["bookingDetailId"],
        serviceName: json["serviceName"],
        bookingServiceStatus: json["bookingServiceStatus"],
    );

    Map<String, dynamic> toJson() => {
        "bookingDetailId": bookingDetailId,
        "serviceName": serviceName,
        "bookingServiceStatus": bookingServiceStatus,
    };
}
