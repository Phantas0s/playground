var t *template.Template
var l = flag.String("location", "http://localhost:8080". "A location")

var tpl = `<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<title>A Demo</title>
		<link rel="stylesheet" href="{{.Location}}/styles.css">
	</head>
	<body>
		<p>A demo.</p>
	</body>
</html>`

func servePage(res http.ResponseWriter, req *http.Request) {
	data := struct{ Location *string } {
		Location: l,
	}
	t.Execute(res, data)
}
