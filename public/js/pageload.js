var page = require('webpage').create();
page.open('http://example.com', function(status) {
  console.log("Status: " + status);
  if(status === "success") {
    console.log("Sucessful");
  } else {
    console.log("Failure");
  }
  phantom.exit();
});