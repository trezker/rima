module application.Database;

import vibe.db.mongo.mongo;

Database GetDatabase(string dbsuffix) {
	return new Database(dbsuffix);
}

class Database {
	MongoClient client;
	string dbname;

	this(string dbsuffix) {
		client = connectMongoDB("mongodb://127.0.0.1");
		dbname = "rima";
		if(dbsuffix) {
			dbname ~= "_" ~ dbsuffix;
		}
	}

	public MongoClient GetClient() {
		return client;
	}

	public MongoCollection GetCollection(string name) {
		return client.getCollection(dbname ~ "." ~ name);
	}

	public void Sync() {
		auto db = client.getDatabase(dbname);
		db.fsync();
	}

	public void ClearCollection(string name) {
		auto collection = GetCollection(name);
		collection.remove();
		Sync();
	}
}