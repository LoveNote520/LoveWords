import 'dart:convert';
import 'dart:io';

void main() {
  // 示例 JSON 数据
  String jsonStr = '''
    {
      "name": "Company",
      "employees": [
        {
          "name": "CEO",
          "employees": [
            {
              "name": "Manager1",
              "employees": [
                {"name": "Employee1"},
                {"name": "Employee2"}
              ]
            },
            {
              "name": "Manager2",
              "employees": [
                {"name": "Employee3"},
                {"name": "Employee4"}
              ]
            }
          ]
        }
      ]
    }
  ''';

  // 将 JSON 字符串解析为 Dart 对象
  Map<String, dynamic> companyMap = json.decode(jsonStr);

  // 使用递归方法处理组织架构
  Organization organization = Organization.fromJson(companyMap);

  // 打印组织架构
  organization.printOrganization();
}

class Organization {
  String name;
  List<Employee> employees;

  Organization({required this.name, required this.employees});

  // 通过 JSON 解析构建组织架构
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['name'],
      employees: (json['employees'] as List<dynamic>).map((e) => Employee.fromJson(e)).toList(),
    );
  }

  // 打印组织架构
  void printOrganization({int depth = 0}) {
    for (int i = 0; i < depth; i++) {
      // 缩进
      stdout.write('  ');
    }
    print('Organization: $name');
    for (var employee in employees) {
      employee.printEmployee(depth: depth + 1);
    }
  }
}

class Employee {
  String name;
  List<Employee> employees;

  Employee({required this.name, required this.employees});

  // 通过 JSON 解析构建员工
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      employees: (json['employees'] as List<dynamic>?)?.map((e) => Employee.fromJson(e)).toList() ?? [],
    );
  }

  // 打印员工
  void printEmployee({int depth = 0}) {
    for (int i = 0; i < depth; i++) {
      // 缩进
      stdout.write('  ');
    }
    print('Employee: $name');
    for (var employee in employees) {
      employee.printEmployee(depth: depth + 1);
    }
  }
}
