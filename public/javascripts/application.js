$(function() {
	alert("hello");
  $("#athletes_list th a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#athletes_search input").keyup(function() {
    $.get($("#athletes_search").attr("action"), $("#athletes_search").serialize(), null, "script");
    return false;
  });
});