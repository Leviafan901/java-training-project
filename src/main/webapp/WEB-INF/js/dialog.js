var dialog = document.querySelector('dialog');
document.querySelector('#show').onclick = function() {
	dialog.show(); // close dialog window
};

document.querySelector('#close').onclick = function() {
	dialog.close(); // close dialog window
};

function myFunction() {
	document.getElementById("return_value").required = true;
	document.getElementById("input_username").required = true;
	document.getElementById("input_password").required = true;
};

document.onkeydown = function(e) {
    // keycode for F5 function
    if (e.keyCode === 116) {
      return false;
    }
    // keycode for backspace
    if (e.keyCode === 8) {
      // try to cancel the backspace
      return false;
    }
 };
  

 function addToCart() {
	var x, text;
	// Get the value of the input field with id="numb"
	x = document.getElementById("return_value").value;
	// If x is Not a Number or less than one 
	if (isNaN(x) || x < 1) {
		text = "Input not valid";
		document.getElementById("return_value").innerHTML = text;
		return false;
	} else {
		return true;
	}
};

function validateNumber(number) {
	if (isNaN(number) || number < 1) {
		return false;
	} else {
		return true;
	}
};

function validateMedicineName(name)
{
    var regex = /\D{2,13}/;

    if(regex.test(name) != false)
    {
        return false;
    }
};

function validateCreationMedicineForm() {
	var name, countInStore, count, dosageMg, price;
	name = document.getElementById("name").value;
	validateMedicineName(name);
	countInStore = document.getElementById("countInStore").value;
	validateNumber(countInStore);
	count = document.getElementById("count").value;
	validateNumber(count);
	dosageMg = document.getElementById("dosageMg").value;
	validateNumber(dosageMg);
	price = document.getElementById("price").value;
	validateNumber(price);
};