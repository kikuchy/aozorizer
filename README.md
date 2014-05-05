# Aozorizer

Small script for making (.kepub).epub file from pixiv to read novel on kobo touch.

## Dependency

- carton    ...    you need `carton` to install depending CPAN modules.

## Setup

First, clone this repository.

Second, download `AozoraEpub3` from [物置Wiki - AozoraEpub3](http://www18.atwiki.jp/hmdev/pages/21.html) and extract all files to this repository directory.

Third, open repository directory in terminal, install CPAN modules.

```
$ carton install
```

## Usage

```
$ carton exec perl aozorize.pl <pixiv novel page's url>
```

For example, to make Epub of `http://www.pixiv.net/novel/show.php?id=3025071`, 

```
$ carton exec perl aozorize.pl http://www.pixiv.net/novel/show.php?id=3025071
```

and you can find the Epub file in current directory.
