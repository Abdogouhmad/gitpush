# push in C

This is a short program built in C called ``cpush``. Its functionality is to is to add, commit, push all the changes that you made into your repo

## Usage

To use this program use ``Makefile`` which will help you with the compiling task

```bash
# compile and clean the object files
make compile && make clean
# then you can move the executable into /usr/bin/ or any other place so where you are able to accesss it
# best place for Linux users is /usr/bin/
sudo mv cpush /usr/bin/
# and now you can run it normally like any command
cpush # to push your code.
```
