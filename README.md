# docker-pandoc-plantuml

include

- pandoc
- wkhtmltopdf
- plantuml
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

## you can call pandoc command directry

```bash:
docker run -v `pwd`:/source mitakeck/pandoc-plantuml pandoc ...
```

## clean up dist folder

```bash:
make clean
```
