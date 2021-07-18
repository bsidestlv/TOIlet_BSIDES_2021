const { exec } = require('child_process');
const express = require('express')
const path = require('path')

const app = express()
const port = 3000

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('images'))

app.get('*', function (req, res) {
  res.sendFile(path.join(__dirname + '/index.html'));
})

app.post('/get_toilet', function (req, res) {
  filter = ""

  if (req.body.put_border == "true") {
    filter += " --filter border"
  }

  if (req.body.toilet_color == "Proud") {
    filter += " --filter gay"
  }
  else if (req.body.toilet_color == "Metal") {
    filter += " --filter metal"
  }

  var command = "toilet " + req.body.toilet_text + filter + " --html"
  exec(command.toString('utf8'), function (err, stdout, stderr) {
    if (err) {
      res.send("nope...");
    } else {
      res.send(stdout);
    }
  });
})

app.listen(port, '0.0.0.0', () => {
  console.log(`Listening on ${port}`)
})
