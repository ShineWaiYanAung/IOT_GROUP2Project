class HomeAutomation {
  LivingRoom livingRoom;
  Garage garage;
  Kitchen kitchen;

  HomeAutomation({
    required this.livingRoom,
    required this.garage,
    required this.kitchen,
  });

  factory HomeAutomation.fromJson(Map<String, dynamic> json) {
    return HomeAutomation(
      livingRoom: LivingRoom.fromJson(json['livingRoom'] ?? {}),
      garage: Garage.fromJson(json['garage'] ?? {}),
      kitchen: Kitchen.fromJson(json['kitchen'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'livingRoom': livingRoom.toJson(),
      'garage': garage.toJson(),
      'kitchen': kitchen.toJson(),
    };
  }
}

class LivingRoom {
  bool mainLightBulb;
  bool lights;
  int temp;
  bool firedoorlockSensor;
  bool fan;

  LivingRoom({
    required this.lights,
    required this.mainLightBulb,
    required this.firedoorlockSensor,
    required this.temp,
    required this.fan,
  });

  factory LivingRoom.fromJson(Map<String, dynamic> json) {
    return LivingRoom(
      lights: json['lights'] ?? false,
      mainLightBulb: json['mainLightBulb'] ?? false,
      firedoorlockSensor: json['firedoorlockSensor'] ?? false,
      fan: json['Fan'] ?? false,
      temp: json['temp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lights': lights,
      'mainLightBulb': mainLightBulb,
      'firedoorlockSensor': firedoorlockSensor,
      'Fan': fan,
      'temp': temp,
    };
  }
}

extension LivingRoomCopyWith on LivingRoom {
  LivingRoom copyWith({
    bool? mainLightBulb,
    bool? lights,
    int? temp,
    bool? firedoorlockSensor,
    bool? fan,
  }) {
    return LivingRoom(
      lights: lights ?? this.lights,
      mainLightBulb: mainLightBulb ?? this.mainLightBulb,
      temp: temp ?? this.temp,
      firedoorlockSensor: firedoorlockSensor ?? this.firedoorlockSensor,
      fan: fan ?? this.fan,
    );
  }
}

class Garage {
  bool doorOpen;

  Garage({required this.doorOpen});

  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      doorOpen: json['doorOpen'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doorOpen': doorOpen,
    };
  }
}

class Kitchen {
  bool ventilationFan;
  bool fireAlarm;
  bool smoke;

  Kitchen({
    required this.ventilationFan,
    required this.fireAlarm,
    required this.smoke,
  });

  factory Kitchen.fromJson(Map<String, dynamic> json) {
    return Kitchen(
      ventilationFan: json['ventilationFan'] ?? false,
      fireAlarm: json['fireAlarm'] ?? false,
      smoke: json['smoke'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ventilationFan': ventilationFan,
      'fireAlarm': fireAlarm,
      'smoke': smoke,
    };
  }
}
