# docs.docker.jp

http://docs.docker.jp

Here is a translated documents  of Docker Version v19.03. 
Original (English) version is here; https://docs.docker.com/ 

# build

Dockerを使ってbuildできます。

## html

`build/html` 以下に生成されます。

```sh
docker run --rm -v `pwd`:/mnt ghcr.io/zembutsu/docs.docker.jp/latex make clean html
```

## pdf

`build/latex` 以下に生成されます。

`Emergency stop.` を避けるために、あらかじめ `\xe2\x80\x93` (EN DASH)を `--` に変換しておきます。

```sh
grep -Flr '–' . | xargs -n1 sed -i 's/–/--/g'
```

そしてビルド

```sh
docker run --rm -v `pwd`:/mnt ghcr.io/zembutsu/docs.docker.jp/latex make clean latexpdfja
```

## Archives

* v1.12 - http://docs.docker.jp/v1.12/
* v1.11 - http://docs.docker.jp/v1.11/
* v1.10 - http://docs.docker.jp/v1.10/
* v1.9 - http://docs.docker.jp/v1.9/
