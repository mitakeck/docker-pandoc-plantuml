nextpagec=$(cat << EOF
=====
EOF
)
nextpagee=$(cat << EOF
<hr />
EOF
)
for mdfile in `find docs | egrep .md$`; do
    mkdir -p tmp/`dirname $mdfile`
    mkdir -p dist/`dirname $mdfile`
    tmpfile=${mdfile}.md
    pdffile=${mdfile%.md}.pdf
    echo "$mdfile -> $pdffile"
    perl -pe "s|$nextpagec|$nextpagee|g" $mdfile > tmp/$tmpfile
    pandoc -c template/github-markdown.css -t html5 tmp/$tmpfile -o dist/$pdffile --filter /root/pandoc-plantuml.py
done