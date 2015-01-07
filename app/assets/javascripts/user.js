

$('#quizload').on("click", function () {
	 $.ajax({
        url: "/quizrem",
        data: "id=0",
        success: function(data){
		//alert(data);
        // $('#questions').html(data);
        }
	});	
});


	

