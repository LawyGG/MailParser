$(document).ready(function () {
  $("button").click(function () {
    try {
      var result = parser.parse($("input").val())
      $('#output').html(JSON.stringify(result,undefined,2));
    } catch (e) {
      
      $('#output').html(String(e));

    }
  });
});
