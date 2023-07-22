# **pushing to github using c and bash**

**hello LAZY people**
this program is made using c language under ```system()``` function, which gives the abiltity to interect with your system. In addition, I have upload a new bash script which does the same task but little more advance *check by yourself :*

![lazy asf](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExeG05c3lrMmltaGRvd2M1eDh4bGJwejNhcnB2bWV6aGJ6MXVteGE4MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Hn1VPQRmzEZUc/giphy.gif)

## cmd used in script

1. ```git add -A``` this cmd tracked and add all files that you made change in.
2. ```git commit -m' '``` this cmd gives a name to your changes you made and you can preview them by the cmd ```git log```.
3. ```git push``` this cmd send changes to github repo.

The **script** gives you to enter the name of the commit, and you can skip this commit as long you are satisfied with the given name _updated_ !! However, you can change the name of the commit. See the **script.c** line: **12**

## **run in linux**

1. download the ```pusher``` and give the permission of executing.

```bash
chmod +x psh
```

2. then run it using the simple syntaxt that is known:

```bash
./psh
```
## **bash script is here!**

I have been working lately on bash script that do a humble task for adding, commiting and push.

```bash
# if it is not executable make it then by:
chmod +x push.sh
# run it then
./push.sh
```

if you are using **zsh** it is heighly recommanded to put in your config ``~/.zshrc`` but if you don't have zsh then it still the same command.

```bash
# you can name it what ever you want
alias push='~/Desktop/push.sh'
```
