if (${searchType} == 1) {
	$("select[name=searchType]").val("1").prop("selected", true);
} else if (${searchType} == 2) {
	$("select[name=searchType]").val("2").prop("selected", true);
} else if (${searchType} == 3) {
	$("select[name=searchType]").val("3").prop("selected", true);
}
				
if (${searchText} != '') {
	$("input[name=searchText]").attr("value", "${searchText}");
}