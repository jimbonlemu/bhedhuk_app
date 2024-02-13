import 'package:bhedhuk_app/data/models/object_of_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class FeedDatabaseHelper {
  static FeedDatabaseHelper? _instanceFeedDatabaseHelper;
  static Database? _database;

  FeedDatabaseHelper._internal() {
    _instanceFeedDatabaseHelper = this;
  }

  factory FeedDatabaseHelper() => _instanceFeedDatabaseHelper ?? FeedDatabaseHelper._internal();

  static const String _favoritedRestaurant = 'tags';

  Future<Database> _initializeFeedDatabase() async {
    var path = await getDatabasesPath();
    var feedDatabase = openDatabase(
      '$path/feed_database.db',
      onCreate: (feedDatabase, version) async {
        await feedDatabase.execute('''CREATE TABLE $_favoritedRestaurant(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating NUMERIC
      )''');
      },
      version: 1,
    );
    return feedDatabase;
  }

  Future<Database?> get databaseInitiate async {
    _database ??= await _initializeFeedDatabase();
    return _database;
  }

  Future<void> insertFavoritedRestaurant(
      ObjectOfRestaurant singleRestaurant) async {
    final db = await databaseInitiate;
    await db!.insert(_favoritedRestaurant, singleRestaurant.toJson());
  }

  Future<List<ObjectOfRestaurant>> getListFavoritedRestaurant() async {
    final db = await databaseInitiate;
    List<Map<String, dynamic>> results = await db!.query(_favoritedRestaurant);
    return results
        .map((result) => ObjectOfRestaurant.fromJson(result))
        .toList();
  }

  Future<Map> getFavoritedRestaurantById(String restaurantId) async {
    final db = await databaseInitiate;

    List<Map<String, dynamic>> results = await db!.query(
      _favoritedRestaurant,
      where: 'id = ?',
      whereArgs: [restaurantId],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavoritedRestaurant(String restaurantId) async {
    final db = await databaseInitiate;

    await db!.delete(_favoritedRestaurant,
        where: 'id = ?', whereArgs: [restaurantId]);
  }

  Future<List<ObjectOfRestaurant>> searchRestaurant(String query) async {
    final db = await databaseInitiate;
    List<Map<String, dynamic>> results = await db!.query(
      _favoritedRestaurant,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return results
        .map((result) => ObjectOfRestaurant.fromJson(result))
        .toList();
  }
}
