---
title: "SPS database"
linkTitle: "SPS database"
type: docs
weight: 9
---
*****

SPS database is a small SQLite database which stores some basic app information, 
the project encryption key pair, account information. The database is controlled 
by 3 SPS R6 classes: 

- **spsDb**: basic database management, queries. 
- **spsEncryption**: Interact with the SHA256 key pair in the database to encrypt 
  strings, and files. Also methods to view or change the key pair, inherits `spsDb`
- **spsAcount**: use the encyption key pair to manage users and admin accounts in 
  SPS, inherits `spsDb` and `spsEncryption`.



First to create a SPS project

```r
suppressPackageStartupMessages(library(systemPipeShiny))
```


```r
app_path <- "."
spsInit(app_path = app_path, overwrite = TRUE, open_files = FALSE)
```


```
## [SPS-DANGER] 2021-04-22 15:45:04 Done, Db created at '/tmp/Rtmp3KQ3pG/SPS_20210422/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-22 15:45:04 Key md5 1d1f76c8eecddb382ee2db097d6edbe9
## [SPS-INFO] 2021-04-22 15:45:04 SPS project setup done!
```

You can see a database created on a SPS project initiation, you should see a message 
like this:
```
[SPS-DANGER] 2021-04-19 11:06:53 Done, Db created at 
```

Then we can use different class methods to interact with the database.

## `spsDb` class
Reference manual under [SPS Functions](/sps/funcs/sps/reference/spsDb.html).

Create a class object:

```r
mydb <- spsDb$new()
```

```
## [SPS-INFO] 2021-04-22 15:45:04 Created SPS database method container
```

### create new db
If there is no database, we can create one:

```r
# delete current one first
try(file.remove("config/sps.db"))
## [1] TRUE
# create a new one
mydb$createDb()
## [SPS-INFO] 2021-04-22 15:45:04 Creating SPS db...
## [SPS-DANGER] 2021-04-22 15:45:04 Done, Db created at 'config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-22 15:45:04 Key md5 6306a50abcf3c7618566911a793b0405
```

<p class="text-danger">If you create a new database, all information in the old database
will be overwritten. All old information will be lost</p>

### Get tables 

```r
# meta info table
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210422154504
```

```r
# raw blob table to store keys
mydb$queryValue("sps_raw")
```

```
##   info         value
## 1  key blob[1.36 kB]
```

```r
# account table
mydb$queryValue("sps_account")
```

```
##   account                                                             pass
## 1   admin bef2094c429fa5b0ff7a37abc6bf8dd31c29fa2acd783a2303935d2b8664ea21
## 2    user 12842a62c410af0f4b4dc866283a90f7b7c42c9d5ca0d0e1c812dca11021b052
##    role
## 1 admin
## 2  user
```

### Insert new records(rows)
To add a new row, values of all columns needs to be passed in a SQL string

```r
mydb$queryInsert("sps_meta", value = "'new1', '1'")
```

```
## [SPS-INFO] 2021-04-22 15:45:04 Inerted 1 rows
```

Or pass in a vector:

```r
mydb$queryInsert("sps_meta", value = c("'new2'", "'2'"))
```

```
## [SPS-INFO] 2021-04-22 15:45:04 Inerted 1 rows
```

```r
# check the new table 
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210422154504
## 2          new1              1
## 3          new2              2
```

### change values

```r
mydb$queryUpdate("sps_meta", value = '234', col = "value", WHERE = "info = 'new1'")
```

```
## [SPS-INFO] 2021-04-22 15:45:04 Updated 1 rows
```

```r
# check the update
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210422154504
## 2          new1            234
## 3          new2              2
```

### remove values

```r
mydb$queryDel("sps_meta", WHERE = "value = '234'")
```

```
## [SPS-INFO] 2021-04-22 15:45:05 Deleted 1 rows
```

```r
# check again 
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210422154504
## 2          new2              2
```


## `spsEncryption` class
Reference manual under [SPS Functions](/sps/funcs/sps/reference/spsEncryption.html).

Start by creating a class object

```r
my_ecpt <- spsEncryption$new()
## [SPS-INFO] 2021-04-22 15:45:05 Created SPS encryption method container
## [SPS-INFO] 2021-04-22 15:45:05 Default SPS-db found and is working
```

### Get current key
To see the public and private keys (in {[openssil{blk}](https://github.com/jeroen/openssl)} format):

```r
# private
my_ecpt$keyGet()
```

```
## [2048-bit rsa private key]
## md5: 6306a50abcf3c7618566911a793b0405
```

```r
# public
my_ecpt$keyGet()$pubkey
```

```
## [2048-bit rsa public key]
## md5: 6306a50abcf3c7618566911a793b0405
```

### Change the encyption key
<p class="text-danger text-bold" style="font-weight: 600;">Be super careful to change the encryption key. This will
result any file encrypted by the old key pair unlockable and the password of all 
current accounts invalid.</p>

By default it will prevent you to change the key in case you accidentally run this 
method

```r
my_ecpt$keyChange()
```

```
## [SPS-DANGER] 2021-04-22 15:45:05 
## change this key will result all accounts' password failed to
## authenticate. You have to regenerate all password for all
## accounts. All encrypted file using the old key will fail to
## decrypt. There is NO way to RECOVER the old key, password
## and files. If you wish to continue, recall this function
## with `confirm = TRUE`.
```

Unless you are super sure with a confirmation

```r
my_ecpt$keyChange(confirm = TRUE)
```

```
## [SPS-INFO] 2021-04-22 15:45:05 md5 42e4b167ba388a9e797608eb4e466a18
```


### Encrypt files

```r
# imagine a file has one line "test"
writeLines(text = "test", con = "test.txt")
my_ecpt$encrypt("test.txt", "test.bin", overwrite = TRUE)
```

### Decrypt files

```r
my_ecpt$decrypt("test.bin", "test_decpt.txt", overwrite = TRUE)
```

Check the decrypted file content

```r
readLines('test_decpt.txt')
```

```
## [1] "test"
```



## `spsAcount` class
This class is discussed in details in the [Accounts, login and admin](../login).



