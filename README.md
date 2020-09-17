# macOS Material Icons

![Screenshot](https://github.com/128keaton/macOS-Material-Icons/blob/master/screenshot.png?raw=true)


# Building

First, clone the repository to your choice of directory:
```
$ cd ~/Documents && git clone --recurse-submodules --remote-submodules https://github.com/128keaton/macOS-Material-Icons
```


Before opening in Xcode, please run the `copy-icons.sh` script:
```
$ cd macOS-Material-Icons && ./copy-icons.sh
Creating file structure
Copying filled icons
Copying outlined icons
Copying rounded icons
Copying two-tone icons
Copying sharp icons
Done!
```

Then, open the project in Xcode:
```
$ open Material\ Icons.xcodeproj
```
