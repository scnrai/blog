$(document).on("click","#randno", function() {
	var daa= "<%= rand(1..5) %>"
  var randomnumber = Math.floor(Math.random() * 100);
  //$('#random').html("Random No:" + randomnumber);
$.ajax({
	url :'/home/generate_random_numbers',
	
	});
});