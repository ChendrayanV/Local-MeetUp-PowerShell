var express = require('express'),
    app = express(),
    path = require('path'),
    bodyparser = require('body-parser'),
    pug = require('pug'),
    shell = require('node-powershell'),
    ps = new shell({
        executionPolicy: 'bypass',
        noProfile: true
    });
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.get('/', function (request, response) {
    response.render('index')
});

app.get('/about', function (request, response) {
    response.render('about')
})
// Get-SystemInformation
app.get('/GetSystemInformation', function (request, response) {
    ps.addCommand("./scripts/SystemInformation.ps1")
    ps.invoke().then(output => {
        var SystemInformation = JSON.parse(output)
        response.render('SystemInformation', {
            results: SystemInformation
        })
    })
})
app.listen(3000)
console.log('Your application is hosted!')