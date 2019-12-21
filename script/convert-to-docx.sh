nextpagec=$(cat << EOF
=====
EOF
)
nextpagee=$(cat << EOF
\`\`\`{=openxml}
<w:p><w:pPr><w:sectPr><w:type w:val="nextPage" /></w:sectPr></w:pPr></w:p>
\`\`\`
EOF
)
# mkdir tmp
for mdfile in `find docs | egrep .md$`; do
    mkdir -p tmp/`dirname $mdfile`
    mkdir -p dist/`dirname $mdfile`
    tmpfile=${mdfile}.md
    docfile=${mdfile%.md}.docx
    echo "$mdfile -> $docfile"
    # sed -e "s/$nextpagec/$nextpagee/g" $mdfile
    perl -pe "s|$nextpagec|$nextpagee|g" $mdfile > tmp/$tmpfile
    pandoc --reference-doc=template/template.docx tmp/$tmpfile -o dist/$docfile --filter /root/pandoc-plantuml.py
done
rm -rf tmp