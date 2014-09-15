// // require at_who

// // Define MagicBox constructor
// function MagicBox(opts) {
// 	this.init(opts);
// }

// MagicBox.prototype.init = function(opts) {
// 	if(opts.fieldId === undefined) throw 'Must define fieldId!!';
// 	this.fieldId = opts.fieldId;
// 	this.controller = new Controller(opts);
// 	this.model = new Model(opts);
// 	this.view = new View(opts);
// }


// ////////////////////
// // View: Responsible for displaying the showResults

// function View(opts) {
// 	this.init(opts);
// }

// View.prototype.init = function(opts) {
// 	this.fieldId = opts.fieldId;
// }

// View.prototype.createMessage = function(text) {
// 	var messageContainer;
// 	messageContainer = document.createElement('div');
// 	messageContainer.innerHTML = '<p>' + text + '</p>';
// 	messageContainer.class = 'command-message'
// 	document.getElementsByTagName('body')[0].appendChild(messageContainer);
// }

// ////////////////
// // Controller: Responsible for binding events and holding logic

// function Controller(opts) {
// 	this.init(opts);
// }

// Controller.prototype.init = function(opts) {
// 	this.fieldId = opts.fieldId;
// 	AtJsCaller.init(this.fieldId);
// 	this.bindEvents();
// }

// Controller.prototype.bindEvents = function() {
// 	var commandBox, _this, view;
// 	commandBox = document.getElementById('command_box');
// 	_this = this;
// 	$(commandBox).on('ajax:success', function(e, data, status, xhr) {
// 		this.reset();
// 		view = new View({});
// 		view.createMessage(data.message);
// 	});
// }
// ///////////////
// // Model: Responsible for storing data

// function Model(opts) {
// 	this.init(opts);
// }

// Model.prototype.init = function(opts) {
// 	this.fieldId = opts.fieldId;
// 	this.dataStore = {};
// };


// ////////////////
// // CursorFinder

// AtJsCaller = (function(){

// 	var $field;

// 	function init(fieldId) {
// 		$field = $('#' + fieldId);
// 		createAtObject();
// 	}

// 	function createAtObject() {
// 		$field.atwho({
//     		at: "$$",
//     		data:['email']
// 		})
// 	}

// 	return {
// 		init: init
// 	};
// })();


// ////////////
// // Initialize

// $(function(){
// 	var opts = { fieldId: 'wall_command'};
// 	var mgb = new MagicBox(opts);
// });
