# ----------------------------------------------------------------------------

#                  CONFIDENTIAL AND PROPRIETARY INFORMATION
#                  ========================================

# Unpublished copyright (c) 2008 Embecosm. All Rights Reserved.

# This file contains confidential and proprietary information of Embecosm and
# is protected by copyright, trade secret and other regional, national and
# international laws, and may be embodied in patents issued or pending.

# Receipt or possession of this file does not convey any rights to use,
# reproduce, disclose its contents, or to manufacture, or sell anything it may
# describe.

# Reproduction, disclosure or use without specific written authorization of
# Embecosm is strictly forbidden.

# Reverse engineering is prohibited.

# ----------------------------------------------------------------------------

# Linux makefile for the System TLM 2.0 simple transactions for OR1K
# application note.

# $Id$

# We just specify the root of the document name. Everything else is done for
# us (we use all the defaults).

DOCROOT        = embecosm-howto-gdb-porting-ean3-issue-2

# ----------------------------------------------------------------------------
# Others do all the hard work

include $(HOME)/svntrunk/Documentation/local_scripts/linux_book.mk


.PHONY: spell
spell:
	aspell --lang=en create master ./custom.dict < ./custom.wordlist
	aspell --master=en_US --mode=sgml --add-extra-dicts=./custom.dict \
		-c $(DOCROOT).docbook