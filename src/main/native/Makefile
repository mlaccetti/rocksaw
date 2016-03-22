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

UNAME  := $(shell uname)
CYGWIN := $(findstring CYGWIN,$(UNAME))
DARWIN := $(findstring Darwin,$(UNAME))

MKDIR_P  = mkdir -p
CC       = gcc
SHARED   = -shared
CFLAGS   = -Wall -O2 -pipe -D_REENTRANT
WINSOCK  = ws2_32
EXTRA_LDFLAGS  =
EXTRA_CPPFLAGS =
LDFLAGS  = $(EXTRA_LDFLAGS)
CPPFLAGS = $(EXTRA_CPPFLAGS)
LIBNAME  = librocksaw
LIBEXTENSION = so
OUT_DIR  = ../../../target/native

ifeq ($(DARWIN),Darwin)
  LIBEXTENSION = jnilib
  CPPFLAGS += -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/darwin
  LDFLAGS += -dynamiclib -framework JavaVM
  SHARED =
else
  ifeq ($(CYGWIN),CYGWIN)
    override CC += -mno-cygwin
    CPPFLAGS += -D__int64="long long"
    LDFLAGS += -Wl,--kill-at -l$(WINSOCK)
    JDK_HOME := $(shell cygpath $(JDK_HOME))
    LIBNAME      = rocksaw
    LIBEXTENSION = dll
  endif

  JAVA_INCDIR      = $(JDK_HOME)/include
  JAVA_INCDIR_PLAF = $(dir $(wildcard $(JAVA_INCDIR)/*/jni_md.h))
  CPPFLAGS += -I$(JAVA_INCDIR) -I$(JAVA_INCDIR_PLAF)
  CFLAGS += -ansi -pthread -fPIC -DPIC
endif

SRC := $(shell find . -name "*.c" -print)
OBJ := $(SRC:%.c=%.o)

CLEAN_EXTENSIONS = o $(LIBEXTENSION)

LIBROCKSAW = $(LIBNAME).$(LIBEXTENSION)

all: directories $(LIBROCKSAW)

directories:
	$(MKDIR_P) $(OUT_DIR)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(OUT_DIR)/$@

$(LIBROCKSAW): $(OBJ)
	$(CC) $(SHARED) -o $(OUT_DIR)/$@ $(OUT_DIR)/$^ $(LDFLAGS)

clean:
	rm -fR $(OUT_DIR)
