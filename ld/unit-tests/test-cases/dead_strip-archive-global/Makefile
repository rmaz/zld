##
# Copyright (c) 2006 Apple Computer, Inc. All rights reserved.
#
# @APPLE_LICENSE_HEADER_START@
# 
# This file contains Original Code and/or Modifications of Original Code
# as defined in and that are subject to the Apple Public Source License
# Version 2.0 (the 'License'). You may not use this file except in
# compliance with the License. Please obtain a copy of the License at
# http://www.opensource.apple.com/apsl/ and read it before using this
# file.
# 
# The Original Code and all software distributed under the License are
# distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
# EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
# INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
# Please see the License for the specific language governing rights and
# limitations under the License.
# 
# @APPLE_LICENSE_HEADER_END@
##
TESTROOT = ../..
include ${TESTROOT}/include/common.makefile

#
# Tests that a global symbol in an archive will stil be exported (and not dead stripped).
#

run: all

all:
	${CC} ${CCFLAGS} foo.c -c -o foo.o
	${FAIL_IF_BAD_OBJ} foo.o
	libtool -static foo.o -o libfoo.a
	${CC} ${CCFLAGS}  main.c -dynamiclib -Os libfoo.a -dead_strip -o libmain.dylib
	nm libmain.dylib | grep _bar | ${FAIL_IF_EMPTY}
	nm libmain.dylib | grep _baz | ${FAIL_IF_STDIN}
	${PASS_IFF_GOOD_MACHO} libmain.dylib
	

clean:
	rm -rf *.dylib *.a *.o
