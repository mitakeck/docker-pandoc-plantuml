build:
	docker build -t mitakeck/pandoc-plantuml docker/

local-doc: template/template.docx
	sh script/convert-to-docx.sh

doc:
	docker run -v `pwd`:/source mitakeck/pandoc-plantuml make local-doc

local-pdf:
	sh script/convert-to-pdf.sh

pdf:
	docker run -v `pwd`:/source mitakeck/pandoc-plantuml make local-pdf

all:
	make doc
	make pdf

clean:
	rm dist/*
	rm -r plantuml-images