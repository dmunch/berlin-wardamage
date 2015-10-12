var geojsonvt = require('geojson-vt');
var fs = require('fs');
var vtpbf = require('vt-pbf')

var data1 = fs.readFileSync("./data/wardamage_01_WGS84.json", 'utf8');
var data2 = fs.readFileSync("./data/wardamage_02_WGS84.json", 'utf8');

var jsonvtOptions = {
  maxZoom: 17,
  indexMaxZoom: 17,
  tolerance: 0.1,
  debug: 0
};

var tileIndex1 = geojsonvt(JSON.parse(data1), jsonvtOptions);
var tileIndex2 = geojsonvt(JSON.parse(data2), jsonvtOptions);

var express = require('express');
var app = express();

app.use(express.static(__dirname + '/public/'));
app.use(express.static(__dirname + '/node_modules/'));

app.get('/layers/:type/:z/:x/:y/', function (req, res) {
  var z = parseInt(req.params.z);
  var x = parseInt(req.params.x);
  var y = parseInt(req.params.y);
  var type = parseInt(req.params.type);

  var tile = undefined;

  if(type == 1) {
    tile = tileIndex1.getTile(z, x, y);
  } else {
    tile = tileIndex2.getTile(z, x, y);
  }

  var buff = vtpbf.fromGeojsonVt({ 'geojsonLayer': tile });
  res.send(buff);
});

var server = app.listen(3000, function () {
	var host = server.address().address;
	var port = server.address().port;

	console.log('App listening at http://%s:%s', host, port);
});
