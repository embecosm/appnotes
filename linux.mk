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

# Linux makefile for the System TLM 2.0 for ORPSoC application note

# $Id


ROOTNAME = systemc_tlm-2.0_for_orpsoc
SRC      = $(ROOTNAME).docbook


# ----------------------------------------------------------------------------
# Make HTML, chunked HTML and PDF versions of the documentation

.PHONY: all
all: html html_chunked pdf txt


# ----------------------------------------------------------------------------
# Make the HTML version. Note that we use XHTML

.PHONY: html
html:
	xmlto xhtml-nochunks $(SRC)


# ----------------------------------------------------------------------------
# Make the chunked HTML version. Note that we use XHTML

.PHONY: html_chunked
html_chunked:
	mkdir -p html
	xmlto -o html html $(SRC)



# ----------------------------------------------------------------------------
# Make the PDF version

.PHONY: pdf
pdf:
	xmlto pdf $(SRC)


# ----------------------------------------------------------------------------
# Make the text version

.PHONY: txt
txt:
	xmlto txt $(SRC)


# ----------------------------------------------------------------------------
# Clean up

.PHONY: clean
clean:
	$(RM)    *.html
	$(RM) -r html
	$(RM)    *.pdf
	$(RM)    *.txt
	$(RM)     *~
