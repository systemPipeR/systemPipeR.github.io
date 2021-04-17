---
title: "SPS database"
linkTitle: "SPS database"
type: docs
weight: 9
---
*****

SPS database is a small SQLite database which stores some basic app information, 
the project encryption key pair, account information



First to create a SPS project

```r
suppressPackageStartupMessages(library(systemPipeShiny))
```


```r
app_path <- "."
spsInit(app_path = app_path, overwrite = TRUE, open_files = FALSE)
```


```
## [SPS-INFO] 2021-04-16 14:50:29 Start to create a new SPS project
## [SPS-INFO] 2021-04-16 14:50:29 Create project under /tmp/RtmpCRl31n/SPS_20210416
## [SPS-INFO] 2021-04-16 14:50:29 Now copy files
## [SPS-INFO] 2021-04-16 14:50:29 Create SPS database
## [SPS-INFO] 2021-04-16 14:50:29 Created SPS database method container
## [SPS-INFO] 2021-04-16 14:50:29 Creating SPS db...
## [SPS-DANGER] 2021-04-16 14:50:30 Done, Db created at '/tmp/RtmpCRl31n/SPS_20210416/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-16 14:50:30 Key md5 8c3c347139245d13bf047c945b7eb1d0
## [SPS-INFO] 2021-04-16 14:50:30 SPS project setup done!
```


## `spsDb` class

## `spsEncryption` class
To see the public and private keys (in {[openssil{blk}](https://github.com/jeroen/openssl)} format):

```r
# private
# acc$keyGet()
# #public
# acc$keyGet()$pubkey
```

## `spsAcount` class
