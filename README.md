# docs.docker.jp

http://docs.docker.jp

Here is a translated documents  of Docker Version 1.13. 
Original (English) version is here; https://docs.docker.com/ 

# build

Dockerを使ってbuildできます。

## html

`build/html` 以下に生成されます。

```
docker build -t docsdockerjp/latex .
docker run --rm -v `pwd`:/mnt docsdockerjp/latex make clean html
```

## pdf

`build/latex` 以下に生成されます。

`Emergency stop.` を避けるために、あらかじめ `\xe2\x80\x93` (EN DASH)を `--` に変換しておきます。

```
grep -r '–' . | cut -d : -f 1 | sort | uniq | xargs -I%% perl -pi -e 's/–/--/g' "%%"
```

そしてビルド

```
docker build -t docsdockerjp/latex .
docker run --rm -v `pwd`:/mnt docsdockerjp/latex make clean latexpdfja
```

## Archives

* v1.12 - http://docs.docker.jp/v1.12/
* v1.11 - http://docs.docker.jp/v1.11/
* v1.10 - http://docs.docker.jp/v1.10/
* v1.9 - http://docs.docker.jp/v1.9/
