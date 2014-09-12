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


// Encapsulate tests in a function
// semicolon ftw
;(function(){

	var sugg, opts, printResults;


	// toggle to turn off printing
	printResults = false;

	assert('a', 'a'); // test for assert function


	// test that MagicBox returns an error if not created with a fieldId
	assertCreateError(MagicBox, {}, 'Must define fieldId!!')

	// test that MagicBox object gets created
	opts = { fieldId: 'myInput' }
	mag = new MagicBox(opts, {});
	assert(mag.fieldId, opts.fieldId);
	// assert(typeof mag.controller, "controller")

	// return And Print
	function rAndP(a) {
		if(printResults) console.log(a);
		return a;
	}

	function assert(a, b) {
		if(a === b) {
			return rAndP(true);
		} else {
			return rAndP(false);
		}
	}

	// function to test creation error

	function assertCreateError(obj, opts, errExpectation) {
		try {
			// if it succeds, show false
			new obj(opts);
			return rAndP(false);

		} catch(err) {
			// if it raises an error, show true
			if(!errExpectation) {
				return rAndP(false);
			} else {
				if(err === errExpectation) {
					return rAndP(true);
				} else {
					return rAndP(false);
				}
			}

		}
	}
})();
