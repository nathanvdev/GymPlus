class Member {
  final int id;
  final String name;
  final String lastname;
  final String membershipStatus;
  final String lastPaymentDate;
  final String nextPaymentDate;
  final String birthdate;

  Member({
    required this.id,
    required this.name,
    required this.lastname,
    required this.membershipStatus,
    required this.lastPaymentDate,
    required this.nextPaymentDate,
    required this.birthdate,
  });
}

class FullMember {
  int? id;
  final String name;
  final String lastname;
  final String phoneNumber;
  String? email;
  String? birthDate;
  final String gender;
  String? emergencyContactPhone;
  String? emergencyContactName;
  String? allergies;
  String? bloodType;
  String? nextDuePayment;
  String? membershipType;
  String? membershipStatus;
  String? lastVisit;

  FullMember({
    this.id,
    required this.name,
    required this.lastname,
    required this.phoneNumber,
    this.email,
    this.birthDate,
    required this.gender,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.allergies,
    this.bloodType,
    this.nextDuePayment,
    this.membershipType,
    this.membershipStatus,
    this.lastVisit,
  });
}


























































































































































// class Employee {
//   Employee(this.id, this.name, this.designation, this.salary);
//   final int id;
//   final String name;
//   final String designation;
//   final int salary;
// }

//  List<Employee> getEmployees() {
//   return[
//   Employee(10001, 'James', 'Project Lead', 20000),
//   Employee(10002, 'Kathryn', 'Manager', 30000),
//   Employee(10003, 'Lara', 'Developer', 15000),
//   Employee(10004, 'Michael', 'Designer', 15000),
//   Employee(10005, 'Martin', 'Developer', 15000),
//   Employee(10006, 'Newberry', 'Developer', 15000),
//   Employee(10007, 'Balnc', 'Developer', 15000),
//   Employee(10008, 'Perry', 'Developer', 15000),
//   Employee(10009, 'Gable', 'Developer', 15000),
//   Employee(10010, 'Grimes', 'Developer', 15000)
//   ];
// }

// List<Employee> employees = getEmployees();
// EmployeeDataSource employeeDataSource = EmployeeDataSource(employees: employees);

// class EmployeeDataSource extends DataGridSource {
//   EmployeeDataSource({required List<Employee> employees}) {
//      _employees = employees
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: 'id', value: e.id),
//               DataGridCell<String>(columnName: 'name', value: e.name),
//               DataGridCell<String>(
//                   columnName: 'designation', value: e.designation),
//               DataGridCell<int>(columnName: 'salary', value: e.salary),
//             ]))
//         .toList();
//   }

//   List<DataGridRow>  _employees = [];

//   @override
//   List<DataGridRow> get rows =>  _employees;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       return Container(
//         alignment: (dataGridCell.columnName == 'id' || dataGridCell.columnName == 'salary')
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         padding: const EdgeInsets.all(16.0),
//         child: Text(dataGridCell.value.toString()),
//       );
//     }).toList());
//   }
// }

