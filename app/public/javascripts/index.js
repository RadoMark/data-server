$(document).ready(function() {
  description = {
    type: "hash",
    prop1: {
      type: "array",
      size: 10,
      element: {
        type: "integer",
        value: 50
      }
    },
    prop2: {
      type: "boolean"
    }
  }
  $.post("data", description, function(data) {
    console.log(data);
  });
});
