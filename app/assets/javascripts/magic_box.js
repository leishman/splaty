// require at_who

// Define MagicBox constructor
function MagicBox(opts) {
	this.init(opts);
}

MagicBox.prototype.init = function(opts) {
	if(opts.fieldId === undefined) throw 'Must define fieldId!!';
	this.fieldId = opts.fieldId;
	this.controller = new Controller(opts);
	this.model = new Model(opts);
	this.view = new View(opts);
}


////////////////////
// View: Responsible for displaying the showResults

function View(opts) {
	this.init(opts);
}

View.prototype.init = function(opts) {
	this.fieldId = opts.fieldId;
}


////////////////
// Controller: Responsible for binding events and holding logic

function Controller(opts) {
	this.init(opts);
}

Controller.prototype.init = function(opts) {
	this.fieldId = opts.fieldId;
	AtJsCaller.init(this.fieldId);
}


///////////////
// Model: Responsible for storing data

function Model(opts) {
	this.init(opts);
}

Model.prototype.init = function(opts) {
	this.fieldId = opts.fieldId;
};


////////////////
// CursorFinder

AtJsCaller = (function(){

	var $field;

	function init(fieldId) {
		$field = $('#' + fieldId);
		createAtObject();
	}

	function createAtObject() {
		$field.atwho({
    		at: "$$",
    		data:['email', 'btc_send', 'publish']
		})
	}

	return {
		init: init
	};
})();


////////////
// Initialize

$(function(){
	var opts = { fieldId: 'wall_command'};
	var mgb = new MagicBox(opts);
});
