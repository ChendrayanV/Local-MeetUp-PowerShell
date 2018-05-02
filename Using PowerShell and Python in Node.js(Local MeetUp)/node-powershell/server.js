var express = require('express');
var shell = require('node-powershell');

var app = express();

var ps = new shell({
    executionPolicy: 'bypass',
    noProfile: true
});

app.get("/:guid", function (req, res) {
    ps.addCommand("./user.ps1", [ {
        name: 'guid', value: req.params.guid
    } ])
    ps.invoke().then(output => {
        console.log(req.params.guid)
        res.end(output);
    })
})

var server = app.listen(8081, function () {

    var host = server.address().address
    var port = server.address().port
    console.log("Example app listening at http://%s:%s", host, port)

})