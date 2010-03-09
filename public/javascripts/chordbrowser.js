// Note: requires prototype.js (http://prototypejs.org)
function renumber_frets(select) {
    var current = select;

    var selected_fret_number = parseInt(select.value);

    while((current = Element.up(current)) &&
	  (current.nodeName != "table")) {
    }
    if (current.nodeName == "table") {
	var fret_numbers = current.select("th.fret_num");
	// start with i=1, not 0: fret_numbers[0] is the 
	// <th> with the dropdown itself.
	for(var i = 1; i < fret_numbers.length; i++) {
	    var current_value = parseInt(fret_numbers[i].innerHTML);
	    fret_numbers[i].innerHTML = selected_fret_number + i;
	}
    }

}