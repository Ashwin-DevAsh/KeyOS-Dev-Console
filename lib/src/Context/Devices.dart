class Devices {
  static var allDevices = [];
  static var activeDevices = [];
  static var inactiveDevices = [];
  static var justInstalled = [];

  static void loadData(data) {
    allDevices = data["allDevices"];
    activeDevices = data["active"];
    inactiveDevices = data["inactive"];
    justInstalled = data["justInstalled"];

    
  }
}
