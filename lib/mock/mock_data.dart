class MockUser {
  const MockUser({
    required this.name,
    required this.email,
    required this.initial,
    required this.avatarColor,
  });

  final String name;
  final String email;
  final String initial;
  final int avatarColor;
}

class MockSchedule {
  MockSchedule({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    this.enabled = true,
  });

  final String id;
  String name;
  String startTime;
  String endTime;
  bool enabled;
}

class MockHistoryItem {
  const MockHistoryItem({
    required this.label,
    required this.value,
    required this.timestamp,
  });

  final String label;
  final String value;
  final String timestamp;
}

abstract final class MockData {
  static const currentUser = MockUser(
    name: 'Karlita Agustin Wardhani',
    email: 'karlitaagustin@gmail.com',
    initial: 'K',
    avatarColor: 0xFF2ECC71,
  );

  static const googleAccounts = [
    MockUser(
      name: 'Karlita Agustin Wardhani',
      email: 'karlitaagustin@gmail.com',
      initial: 'K',
      avatarColor: 0xFF2ECC71,
    ),
    MockUser(
      name: 'Karlita Agustin',
      email: 'karlitaaw19@gmail.com',
      initial: 'K',
      avatarColor: 0xFF8E8E93,
    ),
  ];

  static const ph = '6.5';
  static const tds = '700 ppm';
  static const uv = '3.2';

  static const chartPointsGreen = [
    26.0,
    27.2,
    28.0,
    27.5,
    29.0,
    28.5,
    30.0,
    29.2,
    31.0,
    28.8,
  ];

  static const chartPointsBlue = [
    25.0,
    25.8,
    26.5,
    27.0,
    26.8,
    27.5,
    28.2,
    27.8,
    29.0,
    28.0,
  ];

  static const chartMin = 25.0;
  static const chartAvg = 28.2;
  static const chartMax = 31.0;

  static const history = [
    MockHistoryItem(
      label: 'Water pH',
      value: '6.5',
      timestamp: '23 April 2026 12.00',
    ),
    MockHistoryItem(
      label: 'Water TDS',
      value: '700 ppm',
      timestamp: '23 April 2026 12.00',
    ),
    MockHistoryItem(
      label: 'UV Light',
      value: '3.2',
      timestamp: '23 April 2026 12.00',
    ),
  ];

  static final pumpNames = ['Nutrition Pump A', 'Nutrition Pump B'];

  static List<MockSchedule> initialSchedules() => [
        MockSchedule(
          id: '1',
          name: 'Nutrition Pump A',
          startTime: '06.00',
          endTime: '08.00',
        ),
        MockSchedule(
          id: '2',
          name: 'Nutrition Pump B',
          startTime: '17.00',
          endTime: '19.00',
        ),
      ];
}
