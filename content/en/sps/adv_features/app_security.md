---
title: "App security"
linkTitle: "App security"
type: docs
weight: 8
---


*****

This secetion discusses how different security concerns are handled in SPS.

```r
suppressPackageStartupMessages(library(systemPipeShiny))
```

## SPS mode

SPS has an option of `mode`. This option controls how the **file upload** is handled by SPS.
It can be either "server" or "local", which is asking whether you are running 
the app on the "server" or running on your "local" machine.

- "server": for security, users **do not** have access of file system on the server, 
choose files from users' local computer.
- "local": Assumes the Shiny server and users' local computer is the same machine,
so users **can access** file Shiny server's file system. 

It is first defined in the `global.R` file in a SPS project. 

```r
options(sps = list(
    mode = "local",
    ...
))
```



You can check current setting after the app started for the first time

```r
spsOption("mode")
```

```
## [1] "local"
```

The most affected function is `dynamicFile` and its server side function `dynamicFileServer`.

Server:

![](../server.png)
After clicking the file selection button in SPS, `server` mode uses the default 
shiny file choose, which users can choose from their local computer. You can see 
from the picture above, this is a user operating system built-in file chooser. 


Local:

![](../local.png)
You can see this is different than the "server" mode.  "Local" mode is able to 
use the file system of the shiny deploy environment file system, and it is no longer 
the users' local system. 


This may be confusing for the first time. Remember "server" and "local" mean 
**where** you deploy the shiny app, on the *server* or run on your *local* computer. 

| Mode |  choose file from | file pointing method |
| --- |  --- | --- |
| Server | user local computer | copy to temp |
| Local | the computer where you deploy the app | direct pointer |

### Pro and cons of modes
It **does not** matter if which mode you choose if you run the app **on your own computer**,
because the deploy server and the user computer are the same. 
- However "local" mode will not copy a file to temp after the file chooser, but directly create a pointer. 
- "Server" mode will first upload/copy the file to temp and create a pointer. This 
will cause resources waste if you are running the app on your own computer. You 
already have the file on your computer but now it gets copied to temp before Shiny 
can use it. This will also waste some time to copy the file, especially for large files.
- There is a **limit** for default Shiny upload size which is 24MB in "server" mode.
- You can choose files as large as you desire on "local" mode.


### The security issue of local mode
There is a security concern of "local" mode when the app is deployed on a remote 
server. "local" mode enables users to choose files from the remote server, so 
there is the risk of file leaking and file damaging. 

We recommend **DO NOT** use "local" mode for remote deployment, like <https://shinyapps.io>. 
You can turn the option `warning_toast = TRUE` on global and testing the app before 
deploy. This option will check for security problems and inform you. 

There are cases where you really need users to choose files from the remote 
server, like the Workflow module, where all workflow files are stored on the 
remote server. Then **use a sandbox or container environment** to isolate the app, 
and also **turn on the login page** `login_screen = TRUE` to limit access will be helpful. 


## Warning toast
Set `warning_toast = TRUE` option will check for potential security risks and show 
a pop-up message if there is any risk when app starts. This is option is helpful 
on pre-deployment testing. 
- check if you have changed the default admin page url "admin"
- check if you have changed the default admin user "admin"
- check if you have changed the default user "admin"
- check if you are on "local" mode

![](../warning_toast.png)

## The workflow module 
The workflow module enables users to manage, design, and run workflows directly 
from the app and in the final running workflow session, users are allowed to run 
arbitrary R code in a Rstudio like console in a child R session. 
Running any R code means they can modify your remote system, and use `system` 
commands. 

For [shinyapps.io](https://shinyapps.io), it runs in a container and it reset itself 
once a while, so security is not a big concern, but apparently, shinyapps.io is not a 
place you want to deploy heavy data analysis workflows. Most users will deploy 
the SPS with workflow modules in other cloud computing sites or their own servers. 
For these cases, we recommend you:
1. <p class="text-danger">Turn on the login to give access to limited people.</p>
2. <p class="text-danger">Isolate the app with sandboxes or containers.</p>























