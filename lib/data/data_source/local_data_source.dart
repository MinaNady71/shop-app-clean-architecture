import 'package:flutter_advanced_clean_architecture/data/network/error_handler.dart';

import '../responses/responses_data.dart';

const String CACHE_HOME_KEY = "CACHE_HOME_KEY";
const String CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_HOME_INTERVAL = 60*1000; // 1 minute cache in millis
const CACHE_STORE_DETAILS_INTERVAL = 60*1000; // 1 minute cache in millis

abstract class LocalDataSource{
  Future<HomeResponse> getHomeData();
  Future<StoresDetailsResponse> getStoreDetailsData();
  Future<void> saveHomeCache(HomeResponse homeResponse);
  Future<void> saveStoreDetailsCache(StoresDetailsResponse storesDetailsResponse);
  void clearCache();
  void removeFromCache(String key);


}


class LocalDataSourceImpl implements LocalDataSource{

  //runTimeCache
  Map<String,CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData()async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)){
      // return the response from cache
      return cachedItem.data;
    }else{
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeCache(HomeResponse homeResponse) async{
   cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }


  @override
  Future<StoresDetailsResponse> getStoreDetailsData()async {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)){
      return cachedItem.data;
    }else{
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }

  }

  @override
  Future<void> saveStoreDetailsCache(StoresDetailsResponse storesDetailsResponse) async{
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(storesDetailsResponse);
  }


  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem{
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}


extension CachedItemExtension on CachedItem{
  bool isValid(int expirationTimeMillis){
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeMillis - cacheTime <= expirationTimeMillis;
    return isValid;
  }

}