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

# $Id$

# File locations and names

STYLESHEET_HOME = /usr/share/sgml/docbook/xsl-stylesheets-1.73.2
CUSTOM_HOME    = ../../local_xsl
FONT_HOME      = ../../local_fonts
DOCBOOK_IMAGES = /usr/share/doc/docbook-style-xsl-1.73.2/doc/images
DOCROOT        = systemc_tlm-2.0_for_orpsoc
SRC            = $(DOCROOT).docbook


# ----------------------------------------------------------------------------
# Make HTML, chunked HTML and PDF versions of the documentation

.PHONY: all
all: images $(DOCROOT).html html/index.html $(DOCROOT).pdf

images:
	mkdir -p images
	cp -r $(DOCBOOK_IMAGES)/* images


# ----------------------------------------------------------------------------
# Make the single chunk HTML version. Note that we use XHTML

$(DOCROOT).html: $(SRC)
	xsltproc $(CUSTOM_HOME)/xhtml/embecosm_onechunk.xsl $(SRC)
	mv index.html $(DOCROOT).html \


# ----------------------------------------------------------------------------
# Make the chunked HTML version. Note that we use XHTML

html/index.html: html $(SRC)
	xsltproc $(CUSTOM_HOME)/xhtml/embecosm_chunk.xsl $(SRC)

html:
	mkdir -p html


# ----------------------------------------------------------------------------
# Make the PDF version

$(DOCROOT).pdf: $(DOCROOT).fo
	$(HOME)/tools/fop/fop-0.95beta/fop -c $(FONT_HOME)/config.xml \
		-fo $(DOCROOT).fo -pdf $(DOCROOT).pdf

$(DOCROOT).fo: $(SRC)
	xsltproc --output $(DOCROOT).fo \
		$(CUSTOM_HOME)/fo/embecosm.xsl $(SRC)
#	$(HOME)/tools/xmlindent/xmlindent-0.2.17/xmlindent \
#		< $(DOCROOT).fo > $(DOCROOT)_tidy.fo


# ----------------------------------------------------------------------------
# Clean up

.PHONY: clean
clean:
	$(RM) -r images
	$(RM)    index.html
	$(RM)    $(DOCROOT).html
	$(RM) -r html
	$(RM)    $(DOCROOT).fo
	$(RM)    $(DOCROOT)_tidy.fo
	$(RM)    $(DOCROOT).pdf
	$(RM)     *~
