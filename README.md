# **pushing to github using c and bash**

**hello LAZY people**
**TL;DR**
this gitauto(c) program is made using c language under ```system()``` function, which gives the abiltity to interect with your system. In addition, I have upload a new bash script which does the same task but with a little fun *check by yourself :* I have been working lately on bash script that do a humble task for adding, commiting and push.

![lazy asf](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExeG05c3lrMmltaGRvd2M1eDh4bGJwejNhcnB2bWV6aGJ6MXVteGE4MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Hn1VPQRmzEZUc/giphy.gif)

## cmd used in script

1. ```git add -A```(if needed), which addes all files that are not synced with git.
2. ```git commit -am' '``` this cmd gives a name to your changes you made and you can preview them by the cmd ```git log```.
3. ```git push``` this cmd send changes to github repo.

The **script** gives you to enter the name of the commit, and you can skip this commit as long you are satisfied with the given name _updated_ !! However, you can change the name of the commit. See the **script.c** line: **12**

## **run in linux**

### **automatic installation script**

```curl -fsSL https://github.com/div-styl/gitpush/raw/main/install.sh | sh```

### manual install

1. clone the repo

```bash
git clone https://github.com/div-styl/gitpush.git
```

2. use makefile to build and get your executable file

```bash
make build
```

3. copy the executable to where you want

##### with install:
```bash
install /path/to/gitauto /usr/bin # gitauto or push.sh. /usr/bin or /usr/local/bin
```

##### with cp

```bash
cp /path/to/gitauto /usr/bin # gitauto or push.sh. /usr/bin or /usr/local/bin
```

``` 

4. then run it using the simple syntaxt that is known:

```bash
./gitauto # or ./push.sh

```
