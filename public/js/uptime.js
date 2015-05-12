var page = require('webpage').create();
var args = require('system').args;
// console.log('Hello, world!');
// console.log(args);
// console.log(args[1]);
var params = JSON.parse(args[1]);
// console.log(params['url']);

t = Date.now();
page.open(params['url'], function (status) {
    if (status !== 'success') {
        var result = JSON.stringify({status: 400, message: 'Page failed to load'});
    } else {
        t = Date.now() - t;
        var result = JSON.stringify({status: 200, message: 'Page successfully loaded in ' + t + ' milliseconds.'});
    }
    console.log(result);
    phantom.exit();
});
