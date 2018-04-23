var userViewModel = function() {
	var self = this;
	self.sign_out = function() {
		var data = {};
		data.action = "Logout";
		ajax_post(data).done(function(returnedData) {
			if(returnedData.success == true) {
				window.location.href = window.location.href;
			}
		});
	};

	self.my_account = function() {
		location.hash = "my_account";
	}
};

ko.applyBindings(new userViewModel(), document.getElementById('header'));

hashloaders.my_account = function() {
	ajax_html("/source/html/my_account.html").done(function(returnedData) {
		$("#content").html(returnedData);
	});
}