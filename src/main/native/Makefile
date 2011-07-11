# Copyright 2004-2006 Daniel F. Savarese
# Copyright 2009 Savarese Software Research Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.savarese.com/software/ApacheLicense-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.DEFAULT_GOAL = all

UNAME    := $(shell uname -a)

JAVA_INCDIR      = $(JAVA_HOME)/include
JAVA_INCDIR_PLAF = $(dir $(wildcard $(JAVA_INCDIR)/*/jni_md.h))

CC       = gcc
SHARED   = -shared
CFLAGS   = -Wall -O2 -pipe -D_REENTRANT -ansi
LDFLAGS  = 
LIBNAME  = librocksaw
LIBEXTENSION = so

ifneq (,$(findstring windows32,$(UNAME)))
	CC = x86_64-w64-mingw32-gcc
	CPPFLAGS += -D__int64="long long"
	LDFLAGS += -lWS2_32
	LIBEXTENSION = dll
else
	CFLAGS += -fpic -pthread
endif

CPPFLAGS = -I$(JAVA_INCDIR) -I$(JAVA_INCDIR_PLAF)

SRC := $(wildcard *.c)
OBJ := $(SRC:%.c=%.o)

LIBROCKSAW = $(LIBNAME).$(LIBEXTENSION)

all: $(OBJ) $(LIBROCKSAW)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(LIBROCKSAW): $(OBJ)
	$(CC) $(SHARED) -o $@ $^ $(LDFLAGS)

clean:
	rm -f *.o
	rm -f *.$(LIBEXTENSION)