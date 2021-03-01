import 'package:DevConsole/src/Database/Databasehelper.dart';
import 'package:sembast/sembast.dart';

class DatabaseService{
   static  getPrevCount() async{
        var isExist = await DataBaseHelper.store.record("token").exists(DataBaseHelper.db);
        if(!isExist){
               var prevCount = {
                 "allDevicesCount":0,
                 "activeDevicesCount":0,
                 "inactiveDevicesCount":0,
                 "justInstalledCount":0,
               };
               await DataBaseHelper.store.record("prevCount").put(DataBaseHelper.db,prevCount);     
               return prevCount;
        }else{
          var prevCount = await DataBaseHelper.store.record("prevCount").get(DataBaseHelper.db);
          return prevCount;
        }
    }

    static updatePrevCount({allDevicesCount,activeDevicesCount,inactiveDevicesCount,justInstalledCount}) async{
               var prevCount = {
                 "allDevicesCount":allDevicesCount,
                 "activeDevicesCount":activeDevicesCount,
                 "inactiveDevicesCount":inactiveDevicesCount,
                 "justInstalledCount":justInstalledCount,
               };  
               await DataBaseHelper.store.record("prevCount").delete(DataBaseHelper.db);     
               await DataBaseHelper.store.record("prevCount").put(DataBaseHelper.db,prevCount);     
      
    }
}