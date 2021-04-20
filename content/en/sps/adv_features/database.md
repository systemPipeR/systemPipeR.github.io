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
## [SPS-DANGER] 2021-04-19 22:25:06 Done, Db created at '/tmp/Rtmp4C6Bh7/SPS_20210419/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-19 22:25:06 Key md5 7f1c569a5eed834508476c8bd7cb17d8
## [SPS-INFO] 2021-04-19 22:25:06 SPS project setup done!
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
## [SPS-INFO] 2021-04-19 22:25:06 Created SPS database method container
```

### create new db
If there is no database, we can create one:

```r
# delete current one first
try(file.remove("config/sps.db"))
## [1] TRUE
# create a new one
mydb$createDb()
## [SPS-INFO] 2021-04-19 22:25:06 Creating SPS db...
## [SPS-DANGER] 2021-04-19 22:25:06 Done, Db created at 'config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-19 22:25:06 Key md5 e5f5d7c235c12977b88d4d14406dccf8
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
## 1 creation_date 20210419222506
```

```r
# raw blob table to store keys
mydb$queryValue("sps_raw")
```

```
##   info         value
## 1  key blob[1.37 kB]
```

```r
# account table
mydb$queryValue("sps_account")
```

```
##   account                                                             pass
## 1   admin ab27646ddaf2579a418654a9fab7bc3b199ad8ad5515a8b34a2b6b5af8275acb
## 2    user 3c1cf589b4650892364a098bb4402934d4f14f76bd4191acb19e08e645b3d8e3
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
## [SPS-INFO] 2021-04-19 22:25:06 Inerted 1 rows
```

Or pass in a vector:

```r
mydb$queryInsert("sps_meta", value = c("'new2'", "'2'"))
```

```
## [SPS-INFO] 2021-04-19 22:25:06 Inerted 1 rows
```

```r
# check the new table 
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210419222506
## 2          new1              1
## 3          new2              2
```

### change values

```r
mydb$queryUpdate("sps_meta", value = '234', col = "value", WHERE = "info = 'new1'")
```

```
## [SPS-INFO] 2021-04-19 22:25:06 Updated 1 rows
```

```r
# check the update
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210419222506
## 2          new1            234
## 3          new2              2
```

### remove values

```r
mydb$queryDel("sps_meta", WHERE = "value = '234'")
```

```
## [SPS-INFO] 2021-04-19 22:25:06 Deleted 1 rows
```

```r
# check again 
mydb$queryValue("sps_meta")
```

```
##            info          value
## 1 creation_date 20210419222506
## 2          new2              2
```


## `spsEncryption` class
Reference manual under [SPS Functions](/sps/funcs/sps/reference/spsEncryption.html).

Start by creating a class object

```r
my_ecpt <- spsEncryption$new()
## [SPS-INFO] 2021-04-19 22:25:06 Created SPS encryption method container
## [SPS-INFO] 2021-04-19 22:25:06 Default SPS-db found and is working
```

### Get current key
To see the public and private keys (in {[openssil{blk}](https://github.com/jeroen/openssl)} format):

```r
# private
my_ecpt$keyGet()
```

```
## [2048-bit rsa private key]
## md5: e5f5d7c235c12977b88d4d14406dccf8
```

```r
# public
my_ecpt$keyGet()$pubkey
```

```
## [2048-bit rsa public key]
## md5: e5f5d7c235c12977b88d4d14406dccf8
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
## [SPS-DANGER] 2021-04-19 22:25:06 
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
## [SPS-INFO] 2021-04-19 22:25:07 md5 6cdf4d7ac8ec41f1e159a162a5d380e3
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

