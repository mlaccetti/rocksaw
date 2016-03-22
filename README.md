## RockSaw

TravisCI: [![Build Status](https://travis-ci.org/mlaccetti/rocksaw.png?branch=master)](https://travis-ci.org/mlaccetti/rocksaw)

A fork of RockSaw (http://www.savarese.com/software/rocksaw/) that includes Maven support.

Please note that the JNI stuff needs a bit of love to build - the Makefile was mangled (by me/Michael Laccetti).

### About

RockSaw is a simple API for performing network I/O with raw
sockets in Java.

IPv6 support was graciously funded by ByteSphere Technologies
(www.bytesphere.com).

Commercial support is provided by Savarese Software Research
Corporation (www.savarese.com).

### Requirements

The 1.1.0 version of RockSaw has been compiled and tested on Linux,
Win32 with Cygwin/MinGW/Winsock or Visual C++, and Mac OS X 10.11.4. It
should compile on other POSIX systems using the GNU tool chain.

No binary distributions are presently released; you will have to compile
for yourself.

Java 1.8 or greater is required to compile/run.

### Compiling

You must have the JAVA_HOME environment variable set and pointing to
the directory where the Java Development Kit is installed.  Otherwise,
the JNI headers will not be found.

The project requires `maven` to build; The command `mvn clean package`
should be sufficient to compile the JAR and associated library.

There are very few files in the source tree:

  - src/main/java Java source code
  - src/main/native The C JNI source and Makefile

#### Note about make

The default Makefile requires GNU make.

#### Win32: Visual C++ (Outdated Instructions)

To compile using Visual C++, you have to override the default
compiler command, make command, and makefile properties:

  jni.cc
  jni.make
  jni.makefile

You can override these on the command line or in build.properties.
For example, to compile using Visual C++, you would use the
following command:

  ant -Djni.cc=cl -Djni.make=nmake -Djni.makefile=Makefile.win32 jar

Make sure your JDK_HOME environment variable is set and that
you've run either the vcvars.bat or vsvars32.bat command
(depending on the version of Visual C++ you're using) to set
your paths for the command line tools.

#### Mac OS X

Be sure to set JAVA_HOME to the right location. It will typically be
something like
`/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home`.

  ```
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
  mvn clean pacakge
  ```

### Licensing

RockSaw is
  Copyright 2004-2007 by Daniel F. Savarese
  Copyright 2007-2009 by Savarese Software Research Corporation
and licensed under the Apache License 2.0 as described in the files:

  LICENSE
  NOTICE

### Notes

On most operating systems, you must have root access or administrative
privileges to use raw sockets.  If you are running a firewall, you will have to make sure it allows ICMP requests through.

The API is minimalist, yet functional. Don't hesitate to submit patches
that enhance the functionality.


### Contact

http://www.savarese.com/contact.html
