import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        UserID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        Name TEXT,
        Password TEXT,
        Gender TEXT,
        PassportType TEXT,
        PassportNumber TEXT,
        Nationality TEXT,
        DateOfIssue TEXT,
        DateOfExpiry TEXT
      )""");

    await database.execute("""CREATE TABLE visa(
        VisaID INTEGER PRIMARY KEY AUTOINCREMENT,
        UsersID INTEGER,
        VisaCountry TEXT,
        VisaType TEXT,
        ExpiryDate TEXT,
        FOREIGN KEY (UsersID) REFERENCES users(UserID)
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbpassports.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("...creating a table...");
        await createTable(database);
      },
    );
  }

  Future<bool> loginUser(String passportNumber, String password) async {
    final db = await SQLHelper.db();

    final List<Map<String, dynamic>> userResult = await db.query(
      'users',
      where: 'PassportNumber = ? AND Password = ?',
      whereArgs: [passportNumber, password],
    );

    return userResult.isNotEmpty;
  }

  static Future<void> createUser(
      String name,
      String password,
      String gender,
      String passportType,
      String passportNumber,
      String nationality,
      String dateOfIssue,
      String dateOfExpiry) async {
    final db = await SQLHelper.db();

    final data = {
      'Name': name,
      'Password': password,
      'Gender': gender,
      'PassportType': passportType,
      'PassportNumber': passportNumber,
      'Nationality': nationality,
      'DateOfIssue': dateOfIssue,
      'DateOfExpiry': dateOfExpiry
    };
    await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getUserDetails(
      String passportNumber) async {
    final db = await SQLHelper.db();
    return db.query('users',
        where: "PassportNumber = ?", whereArgs: [passportNumber], limit: 1);
  }

// Creating a new visa
  static Future<void> createVisa(int userid, String visaCountry,
      String visaType, String visaExpiry) async {
    final db = await SQLHelper.db();

    final data = {
      'UsersID': userid,
      'VisaCountry': visaCountry,
      'VisaType': visaType,
      'ExpiryDate': visaExpiry
    };
    await db.insert('visa', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

// Retrieve visas for a specific user
  static Future<List<Map<String, dynamic>>> getVisas(int userid) async {
    final db = await SQLHelper.db();
    return db.query('visa', where: "UsersID = ?", whereArgs: [userid]);
  }

// Delete a user and their associated visas
  static Future<void> deleteVisa(int visaID) async {
    final db = await SQLHelper.db();
    await db.delete('visa', where: 'VisaID = ?', whereArgs: [visaID]);
  }

  // Update an item by id
  static Future<int> updateVisa(
      int id, String VisaCountry, String? VisaType, String? VisaExpiry) async {
    final db = await SQLHelper.db();

    final data = {
      'VisaCountry': VisaCountry,
      'VisaType': VisaType,
      'ExpiryDate': VisaExpiry
    };

    final result =
        await db.update('visa', data, where: "VisaID = ?", whereArgs: [id]);
    return result;
  }

// Delete a user and their associated visas
  static Future<void> deleteUser(int userId) async {
    final db = await SQLHelper.db();
    await db.delete('users', where: 'id = ?', whereArgs: [userId]);
    await db.delete('visa', where: 'userId = ?', whereArgs: [userId]);
  }
}
