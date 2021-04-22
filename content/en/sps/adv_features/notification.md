---
title: "Notification system"
linkTitle: "Notification system"
type: docs
weight: 4
---
*****

## SPS notification system

In SPS, there is a notification dropdown where developers can broadcast new messages 
to users. The dropdown is located on the top-right corner.

<center>

![](../note_main.png)

<caption>Notification Dropdown</caption>

</center>

<br>When a notification item is clicked, details of the notification will be displayed 
in a modal.

<center>

![](../note_view.png)

<caption>Notification Detail Moadal</caption>

</center>

## Official notification
If you only use the original SPS, we will send out new notifications every time 
we update the package or other important things that we want to inform you. 
You should see the icon of the dropdown becomes.
<i class="fa fa-exclamation-triangle"></i> + the message number. If there is no 
message or you have clicked the dropdown, it will become <i class="fa fa-check"></i> + 0.


## Custom notification
If you do not want to receive the official notification or want to write your 
own note to your users, first let us understand how it works.

### Mechanism
Every time when you run the `sps()` main function, it will look for a remote URL
that stores the notification information in **[yaml{blk}](https://yaml.org/)** format.
If this file can be successfully parsed, you will see the notification dropdown menu 
on SPS UI, otherwise no dropdown displayed. 

To define your own notification URL, you need to change the option `note_url` in 
the `global.R` file. Read more about changing [SPS options](../config#app-options).
The default value is a file on Github, which also can be used as your template to write custom 
notification messages:

[https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml{blk}](https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml)

### Notification template
If you download the link above, you should see something like this:

```yaml
############ Create remote messages to notify users in the app #################
## When app starts, it will first try to load this file from online.
## You should place this file somewhere publically reachable online, like Github.
## This file should not be included in your app deployment.
## Add the url of this file to the SPS option `note_url` in "global.R" file

# type: one of 'package' or 'general', required
# expire: note will be displayed before the date, required, YYYY-MM-DD format
# title: string, required
# icon: any font-awesome icon name, default is the "info-circle"
# status: one of primary, success, info, warning, danger, default is "primary"
# pkg_name: string, required if type == 'package', such as "systemPipeShiny"
# version: string, required if type == 'package', such as "1.0.0"
# message: string, optional, the text body of the notification. Be careful with indentations.
- note:
    type: general
    pkg_name:
    version:
    title: Notification broadcasting
    expire: 2099-01-01
    icon:
    status:
    message: |
        ## SPS notifications
        What you are looking at is the SPS notification broadcasting system. It
        display messages to your users by reading a remote `yaml` file stored
        online. SPS will fetch the content of this file and translate it to different
        notes you can see here. So you do not need to re-deploy the app every time
        there is a new notification.
        1. You can customize your own notifications by
           using [this file as template](https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml).
        2. After the modification, place this file in public accessible location, like
           Github, do not inlcude this file in app deployment.
        3. During app deployment, indicate the URL of this file in `global.R`
           file, `note_url:` option.
```

### Template details
Most entries are easy-to-understand. Here are some key points.

#### Indentation
Indentation is **very important** in a yaml file. In the template, we use **4 spaces**
as 1 level of indentation. 

#### Notification start and end
Always start with a `- note:` to define a notification item. After you finish typing 
the message body, leave at least one line blank before starting another notification.


#### `type`
**general**: Use this type to create a general notification. It will ignore `pkg_name` 
and `version` information. 

**package**: A notification that is related to a package updates. This type of note will first 
check if the user has installed the package (single one) with  a version that is 
higher than the specified version number in 
`pkg_name` and `version` entries. If so, the notification will **not be displayed**. 
If not the user will see the notification before expiration date.

#### `expire`
The `expire` decides how long to show users the notification. If current date has 
passed the date in `expire`, the notification will not be displayed. 


#### Message body
Use `|` to start a new line and put the markdown format text body 
in the next indentation level.



















