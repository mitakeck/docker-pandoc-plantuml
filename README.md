# docker-pandoc-plantuml

include

- pandoc
- wkhtmltopdf
- plantuml
- graphviz
- japanese font (Noto font)

## setup pandoc container

```bash:
make build
```

## generate *.docx

```bash:
make doc
```

## generate *.pdf

```bash:
make pdf
```

## you can call `pandoc` command direct

```bash:
docker run -v `pwd`:/source mitakeck/pandoc-plantuml pandoc ...
docker run -v `pwd`:/source mitakeck/pandoc-plantuml pandoc -h
```

## clean up dist folder

```bash:
make clean
```
