import 'package:sqflite/sqflite.dart';
import '../models/object_of_restaurant.dart';

class FeedDatabaseService {
  FeedDatabaseService._internal();
  static final FeedDatabaseService _instanceFeedDatabaseService =
      FeedDatabaseService._internal();

  static Database? _database;

  factory FeedDatabaseService() => _instanceFeedDatabaseService;

  static const String _favoritedTable = 'favorited_table';

  Future<Database> _initializeFeedDatabase() async {
    var path = await getDatabasesPath();
    var feedDatabase = openDatabase(
      '$path/feed_database.db',
      onCreate: (feedDatabase, version) async {
        await feedDatabase.execute('''CREATE TABLE $_favoritedTable(
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
    await db!.insert(_favoritedTable, singleRestaurant.toJson());
  }

  Future<List<ObjectOfRestaurant>> getListFavoritedRestaurant() async {
    final db = await databaseInitiate;
    List<Map<String, dynamic>> results = await db!.query(_favoritedTable);
    return results
        .map((result) => ObjectOfRestaurant.fromJson(result))
        .toList();
  }

  Future<Map> getFavoritedRestaurantById(String restaurantId) async {
    final db = await databaseInitiate;

    List<Map<String, dynamic>> results = await db!.query(
      _favoritedTable,
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

    await db!
        .delete(_favoritedTable, where: 'id = ?', whereArgs: [restaurantId]);
  }

  Future<List<ObjectOfRestaurant>> searchRestaurant(String query) async {
    final db = await databaseInitiate;
    List<Map<String, dynamic>> results = await db!.query(
      _favoritedTable,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return results
        .map((result) => ObjectOfRestaurant.fromJson(result))
        .toList();
  }
}
