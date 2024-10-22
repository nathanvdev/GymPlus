import 'package:frontend/models/measurement.dart';
import 'package:frontend/models/membership_payment.dart';

class Member {
  final int id;
  final String name;
  final String lastname;
  final String membershipStatus;
  final String lastPaymentDate;
  final String nextPaymentDate;
  final String lastVisit;
  final String activeDays;
  final String porfileImage;

  Member({
    required this.id,
    required this.name,
    required this.lastname,
    required this.membershipStatus,
    required this.lastPaymentDate,
    required this.nextPaymentDate,
    required this.lastVisit,
    required this.activeDays,
    required this.porfileImage,
  });
}

class FullMember {
  String id;
  String name;
  String lastname;
  String phoneNumber;
  String email;
  String birthDate;
  String gender;
  String emergencyContactNumber;
  String emergencyContactName;
  String allergies;
  String bloodType;
  String lastPayment;
  String nextDuePayment;
  String membershipType;
  String membershipStatus;
  String lastVisit;
  String activeDays;
  String profileImage;
  String createdAt;

  List<MembershipPayment>? payments;
  List<Measurement>? measurements;

  FullMember({
    required this.id,
    required this.name,
    required this.lastname,
    required this.phoneNumber,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.emergencyContactNumber,
    required this.emergencyContactName,
    required this.allergies,
    required this.bloodType,
    required this.lastPayment,
    required this.nextDuePayment,
    required this.membershipType,
    required this.membershipStatus,
    required this.lastVisit,
    required this.activeDays,
    required this.profileImage,
    required this.createdAt,
    this.payments,
    this.measurements,
  });

  factory FullMember.fromJson(json) {
    final tmpMemberInfo = json['memberInfo'];

    for (var key in tmpMemberInfo.keys) {
      if (tmpMemberInfo[key] == null || tmpMemberInfo[key] == '') {
        if (key == 'profileImage') {
          tmpMemberInfo[key] = '';
        } else {
          tmpMemberInfo[key] = 'N/A';
        }
      }
    }

    List<MembershipPayment> tmpPayments = [];
    json['payments'].forEach((payment) {
      tmpPayments.add(MembershipPayment.fromJson(payment));
    });

    List<Measurement> tmpMeasurements = [];
    json['measurements'].forEach((measurement) {
      tmpMeasurements.add(Measurement.fromJson(measurement));
    });

    String tmpLastPayment;

    try {
      tmpLastPayment = tmpMemberInfo['last_payment'].substring(0, 10);
    } catch (e) {
      tmpLastPayment = 'N/A';
    }

    String tmpNextDuePayment;
    try {
      tmpNextDuePayment = tmpMemberInfo['next_payment'].substring(0, 10);
    } catch (e) {
      tmpNextDuePayment = 'N/A';
    }

    return FullMember(
      id: tmpMemberInfo['id'].toString(),
      name: tmpMemberInfo['name'],
      lastname: tmpMemberInfo['last_name'],
      phoneNumber: tmpMemberInfo['phone_number'].toString(),
      email: tmpMemberInfo['email'],
      birthDate: tmpMemberInfo['date_of_birth'].toString(),
      gender: tmpMemberInfo['gender'],
      emergencyContactNumber:
          tmpMemberInfo['emergency_contact_number'].toString(),
      emergencyContactName: tmpMemberInfo['emergency_contact_name'],
      allergies: tmpMemberInfo['allergies'],
      bloodType: tmpMemberInfo['blood_type'],
      lastPayment: tmpLastPayment,
      nextDuePayment: tmpNextDuePayment,
      membershipType: tmpMemberInfo['membership_type'],
      membershipStatus: tmpMemberInfo['membership_status'],
      lastVisit: tmpMemberInfo['last_visit'],
      activeDays: tmpMemberInfo['active_days'].toString(),
      profileImage: tmpMemberInfo['profileImage'],
      createdAt: tmpMemberInfo['createdAt'].substring(0, 10),
      payments: tmpPayments,
      measurements: tmpMeasurements,
    );
  }

  static FullMember createEmpty() {
    return FullMember(
      id: '0',
      name: 'N/A',
      lastname: 'N/A',
      phoneNumber: 'N/A',
      email: 'N/A',
      birthDate: 'N/A',
      gender: 'N/A',
      emergencyContactNumber: 'N/A',
      emergencyContactName: 'N/A',
      allergies: 'N/A',
      bloodType: 'N/A',
      lastPayment: 'N/A',
      nextDuePayment: 'N/A',
      membershipType: 'N/A',
      membershipStatus: 'N/A',
      lastVisit: 'N/A',
      activeDays: 'N/A',
      profileImage: 'N/A',
      createdAt: 'N/A',
    );
  }
}
