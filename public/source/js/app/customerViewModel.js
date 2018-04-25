var customerViewModel = function() {
	var self = this;

	self.saved_markets = ko.observableArray([]);

	self.open_market_map = function() {
		location.hash = "market_map";
	};

	self.open_market = function() {
		location.hash = "market";
	};

	self.market_map_init = function() {
		var california = {lat: 37.4419, lng: -122.1419};
		self.map = new google.maps.Map(document.getElementById('map'), {
			center: california,
			zoom: 13
		});
	}
};

var customerViewModel = new customerViewModel()

hashloaders[""] = function() {
	ajax_html("/source/html/start.html").done(function(returnedData) {
		$("#content").html(returnedData);
		ko.applyBindings(customerViewModel, $("#content>div")[0]);
	});
}

hashloaders["market_map"] = function() {
	ajax_html("/source/html/market_map.html").done(function(returnedData) {
		$("#content").html(returnedData);
		ko.applyBindings(customerViewModel, $("#content>div")[0]);
		customerViewModel.market_map_init();
	});
}
