$(document).ready(function () {
  $("button").click(function () {
    try {
      var result = parser.parse($('input').val())
      $('#output').html(result);
    } catch (e) {
      
      $('#output').html(String(e));

    }
  });
});
