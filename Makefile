# Makefile for the CS:APP Shell Lab

TEAM = NOBODY
VERSION = 1
HANDINDIR = /afs/cs/academic/class/15213-f02/L5/handin
DRIVER = ./sdriver.pl
TSH = ./tsh
TSHREF = ./tshref
PROGRAMS = ./myspin ./mysplit ./mystop ./myint
TSHARGS = "-p"
CC = gcc
CFLAGS = -Wall -O2
MSG = "*INFO: PID and file name can be different."

all: programs tsh

programs: $(PROGRAMS)

tsh:
	$(CC) $(CFLAGS) -I./include -o $(TSH) ./tsh.c lib/sio.c

##################
# Handin your work
##################
handin:
	cp tsh.c $(HANDINDIR)/$(TEAM)-$(VERSION)-tsh.c


##################
# Regression tests
##################

# Run tests using the student's shell program
test01:
	$(DRIVER) -t trace01.txt -s $(TSH) -a $(TSHARGS)
test02:
	$(DRIVER) -t trace02.txt -s $(TSH) -a $(TSHARGS)
test03:
	$(DRIVER) -t trace03.txt -s $(TSH) -a $(TSHARGS)
test04:
	$(DRIVER) -t trace04.txt -s $(TSH) -a $(TSHARGS)
test05:
	$(DRIVER) -t trace05.txt -s $(TSH) -a $(TSHARGS)
test06:
	$(DRIVER) -t trace06.txt -s $(TSH) -a $(TSHARGS)
test07:
	$(DRIVER) -t trace07.txt -s $(TSH) -a $(TSHARGS)
test08:
	$(DRIVER) -t trace08.txt -s $(TSH) -a $(TSHARGS)
test09:
	$(DRIVER) -t trace09.txt -s $(TSH) -a $(TSHARGS)
test10:
	$(DRIVER) -t trace10.txt -s $(TSH) -a $(TSHARGS)
test11:
	$(DRIVER) -t trace11.txt -s $(TSH) -a $(TSHARGS)
test12:
	$(DRIVER) -t trace12.txt -s $(TSH) -a $(TSHARGS)
test13:
	$(DRIVER) -t trace13.txt -s $(TSH) -a $(TSHARGS)
test14:
	$(DRIVER) -t trace14.txt -s $(TSH) -a $(TSHARGS)
test15:
	$(DRIVER) -t trace15.txt -s $(TSH) -a $(TSHARGS)
test16:
	$(DRIVER) -t trace16.txt -s $(TSH) -a $(TSHARGS)

# Run the tests using the reference shell program
rtest01:
	$(DRIVER) -t trace01.txt -s $(TSHREF) -a $(TSHARGS)
rtest02:
	$(DRIVER) -t trace02.txt -s $(TSHREF) -a $(TSHARGS)
rtest03:
	$(DRIVER) -t trace03.txt -s $(TSHREF) -a $(TSHARGS)
rtest04:
	$(DRIVER) -t trace04.txt -s $(TSHREF) -a $(TSHARGS)
rtest05:
	$(DRIVER) -t trace05.txt -s $(TSHREF) -a $(TSHARGS)
rtest06:
	$(DRIVER) -t trace06.txt -s $(TSHREF) -a $(TSHARGS)
rtest07:
	$(DRIVER) -t trace07.txt -s $(TSHREF) -a $(TSHARGS)
rtest08:
	$(DRIVER) -t trace08.txt -s $(TSHREF) -a $(TSHARGS)
rtest09:
	$(DRIVER) -t trace09.txt -s $(TSHREF) -a $(TSHARGS)
rtest10:
	$(DRIVER) -t trace10.txt -s $(TSHREF) -a $(TSHARGS)
rtest11:
	$(DRIVER) -t trace11.txt -s $(TSHREF) -a $(TSHARGS)
rtest12:
	$(DRIVER) -t trace12.txt -s $(TSHREF) -a $(TSHARGS)
rtest13:
	$(DRIVER) -t trace13.txt -s $(TSHREF) -a $(TSHARGS)
rtest14:
	$(DRIVER) -t trace14.txt -s $(TSHREF) -a $(TSHARGS)
rtest15:
	$(DRIVER) -t trace15.txt -s $(TSHREF) -a $(TSHARGS)
rtest16:
	$(DRIVER) -t trace16.txt -s $(TSHREF) -a $(TSHARGS)

##################
# Output tests
##################

# Run tests using the student's shell program and 
# save the output in file *.result
test01.result:
	make test01 > ./test01.result
test02.result:
	make test02 > ./test02.result
test03.result:
	make test03 > ./test03.result
test04.result:
	make test04 > ./test04.result
test05.result:
	make test05 > ./test05.result
test06.result:
	make test06 > ./test06.result
test07.result:
	make test07 > ./test07.result
test08.result:
	make test08 > ./test08.result
test09.result:
	make test09 > ./test09.result
test10.result:
	make test10 > ./test10.result
test11.result:
	make test11 > ./test11.result
test12.result:
	make test12 > ./test12.result
test13.result:
	make test13 > ./test13.result
test14.result:
	make test14 > ./test14.result
test15.result:
	make test15 > ./test15.result
test16.result:
	make test16 > ./test16.result

# Run the tests using the reference shell program
# save the output in *.result file
rtest01.result:
	make rtest01 > ./rtest01.result
rtest02.result:
	make rtest02 > ./rtest02.result
rtest03.result:
	make rtest03 > ./rtest03.result
rtest04.result:
	make rtest04 > ./rtest04.result
rtest05.result:
	make rtest05 > ./rtest05.result
rtest06.result:
	make rtest06 > ./rtest06.result
rtest07.result:
	make rtest07 > ./rtest07.result
rtest08.result:
	make rtest08 > ./rtest08.result
rtest09.result:
	make rtest09 > ./rtest09.result
rtest10.result:
	make rtest10 > ./rtest10.result
rtest11.result:
	make rtest11 > ./rtest11.result
rtest12.result:
	make rtest12 > ./rtest12.result
rtest13.result:
	make rtest13 > ./rtest13.result
rtest14.result:
	make rtest14 > ./rtest14.result
rtest15.result:
	make rtest15 > ./rtest15.result
rtest16.result:
	make rtest16 > ./rtest16.result

####################
# Output diff check
####################

test01.diff: test01.result rtest01.result
	diff -u ./rtest01.result ./test01.result || (echo "$(MSG)"; exit 0)
test02.diff: test02.result rtest02.result
	diff -u ./rtest02.result ./test02.result || (echo "$(MSG)"; exit 0)
test03.diff: test03.result rtest03.result
	diff -u ./rtest03.result ./test03.result || (echo "$(MSG)"; exit 0)
test04.diff: test04.result rtest04.result
	diff -u ./rtest04.result ./test04.result || (echo "$(MSG)"; exit 0)
test05.diff: test05.result rtest05.result
	diff -u ./rtest05.result ./test05.result || (echo "$(MSG)"; exit 0)
test06.diff: test06.result rtest06.result
	diff -u ./rtest06.result ./test06.result || (echo "$(MSG)"; exit 0)
test07.diff: test07.result rtest07.result
	diff -u ./rtest07.result ./test07.result || (echo "$(MSG)"; exit 0)
test08.diff: test08.result rtest08.result
	diff -u ./rtest08.result ./test08.result || (echo "$(MSG)"; exit 0)
test09.diff: test09.result rtest09.result
	diff -u ./rtest09.result ./test09.result || (echo "$(MSG)"; exit 0)
test10.diff: test10.result rtest10.result
	diff -u ./rtest10.result ./test10.result || (echo "$(MSG)"; exit 0)
test11.diff: test11.result rtest11.result
	diff -u ./rtest11.result ./test11.result || (echo "$(MSG)"; exit 0)
test12.diff: test12.result rtest12.result
	diff -u ./rtest12.result ./test12.result || (echo "$(MSG)"; exit 0)
test13.diff: test13.result rtest13.result
	diff -u ./rtest13.result ./test13.result || (echo "$(MSG)"; exit 0)
test14.diff: test14.result rtest14.result
	diff -u ./rtest14.result ./test14.result || (echo "$(MSG)"; exit 0)
test15.diff: test15.result rtest15.result
	diff -u ./rtest15.result ./test15.result || (echo "$(MSG)"; exit 0)
test16.diff: test16.result rtest16.result
	diff -u ./rtest16.result ./test16.result || (echo "$(MSG)"; exit 0)

####################
# Test all
####################

# Run tests using the student's shell program and 
# save every output in one file ./tsh.out
tests.result:
	$(DRIVER) -t trace01.txt -s $(TSH) -a $(TSHARGS) > ./tests.result
	$(DRIVER) -t trace02.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace03.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace04.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace05.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace06.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace07.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace08.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace09.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace10.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace11.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace12.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace13.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace14.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace15.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result
	$(DRIVER) -t trace16.txt -s $(TSH) -a $(TSHARGS) >> ./tests.result

# Run the tests using the reference shell program
# save the output in one file tshref.out
rtests.result:
	$(DRIVER) -t trace01.txt -s $(TSHREF) -a $(TSHARGS) > ./rtests.result
	$(DRIVER) -t trace02.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace03.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace04.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace05.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace06.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace07.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace08.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace09.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace10.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace11.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace12.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace13.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace14.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace15.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result
	$(DRIVER) -t trace16.txt -s $(TSHREF) -a $(TSHARGS) >> ./rtests.result

tests.diff: tests.result rtests.result
	diff -u ./rtests.result ./tests.result > ./tests.diff || (echo "$(MSG)"; exit 0)

# clean up
clean:
	rm -f $(PROGRAMS) $(TSH) *.o *~ *.result *.diff


