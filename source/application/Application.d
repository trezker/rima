module application.Application;

import std.stdio;
import vibe.http.server;
import vibe.core.log;

import boiler.Ajax;
import boiler.Get;
import boiler.HttpRequest;

import application.Database;
import application.storage.user;
import application.CreateUser;
import application.Login;
import application.Logout;
import application.CurrentUser;

class Application {
	void SetupActions(Ajax ajax, Get get) {
		Database database = GetDatabase(null);
		auto userStorage = new User_storage(database);

		ajax.SetActionCreator("CreateUser", () => new CreateUser(userStorage));
		ajax.SetActionCreator("Login", () => new Login(userStorage));
		ajax.SetActionCreator("Logout", () => new Logout);
		ajax.SetActionCreator("CurrentUser", () => new CurrentUser(userStorage));
	}

	string RewritePath(HttpRequest request) {
		if(!request.session) {
			return "/login";
		}
		return request.path;
	}
}
