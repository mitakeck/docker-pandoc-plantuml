for mdfile in *.md; do
    pdffile=${mdfile%.md}.pdf
    echo "$mdfile -> $pdffile"

    pandoc -c template/github-markdown.css -t html5 $mdfile -o dist/$pdffile --filter /root/pandoc-plantuml.py
done
