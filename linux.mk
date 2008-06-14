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

STYLESHEET_HOME  = /usr/share/sgml/docbook/xsl-stylesheets-1.73.2

# Embecosm standard file locations

EMB_CSS_HOME   = ../../local_css
EMB_XSL_HOME   = ../../local_xsl
EMB_FONT_HOME  = ../../local_fonts
EMB_IMAGE_HOME = ../../local_images

# Info for this document

DOCNAME          = orpsoc_setup
CSSFILE          = appnote_style.css
IMAGE_DIR        = images
CHUNK_DIR        = html

# Styles for this document

ONECHUNK_STYLE   = $(EMB_XSL_HOME)/xhtml/embecosm_appnote_onechunk.xsl
CHUNK_STYLE      = $(EMB_XSL_HOME)/xhtml/embecosm_appnote_chunk.xsl
PDF_STYLE        = $(EMB_XSL_HOME)/fo/embecosm_appnote.xsl


# ----------------------------------------------------------------------------
# Make HTML, chunked HTML and PDF versions of the documentation

.PHONY: all
all: embecosm_files $(DOCNAME).html $(CHUNK_DIR)/index.html $(DOCNAME).pdf

.PHONY: embecosm_files
embecosm_files:
	cp -rf $(EMB_IMAGE_HOME)/* images
	cp -f  $(EMB_CSS_HOME)/$(CSSFILE) .


# ----------------------------------------------------------------------------
# Make the single chunk HTML version. Note that we use XHTML

$(DOCNAME).html: $(DOCNAME).docbook
	xsltproc --stringparam html.stylesheet      "./$(CSSFILE)" \
		 --stringparam img.src.path         "./$(IMAGE_DIR)/" \
		 --stringparam admon.graphics.path  "./$(IMAGE_DIR)/" \
		 --stringparam navig.graphics.path  "./$(IMAGE_DIR)/" \
		$(ONECHUNK_STYLE) $(DOCNAME).docbook
	mv index.html $(DOCNAME).html \


# ----------------------------------------------------------------------------
# Make the chunked HTML version. Note that we use XHTML

$(CHUNK_DIR)/index.html: $(CHUNK_DIR) $(DOCNAME).docbook
	xsltproc --stringparam base.dir             "html/" \
		 --stringparam html.stylesheet      "../$(CSSFILE)" \
		 --stringparam img.src.path         "../$(IMAGE_DIR)/" \
		 --stringparam admon.graphics.path  "../$(IMAGE_DIR)/" \
		 --stringparam navig.graphics.path  "../$(IMAGE_DIR)/" \
		 $(CHUNK_STYLE) $(DOCNAME).docbook

$(CHUNK_DIR):
	mkdir -p $(CHUNK_DIR)


# ----------------------------------------------------------------------------
# Make the PDF version

$(DOCNAME).pdf: $(DOCNAME).fo
	$(HOME)/tools/fop/fop-0.95beta/fop -c $(EMB_FONT_HOME)/config.xml \
		-fo $(DOCNAME).fo -pdf $(DOCNAME).pdf

$(DOCNAME).fo: $(DOCNAME).docbook
	xsltproc --output $(DOCNAME).fo \
		 --stringparam img.src.path         "./$(IMAGE_DIR)/" \
		 --stringparam admon.graphics.path  "./$(IMAGE_DIR)/" \
		 --stringparam navig.graphics.path  "./$(IMAGE_DIR)/" \
		 $(PDF_STYLE) $(DOCNAME).docbook


# ----------------------------------------------------------------------------
# Clean up. Includes sucking out the local standard images from the images
# directory.

.PHONY: clean
clean:
	ls $(EMB_IMAGE_HOME) | (cd images ; xargs $(RM) -r)
	$(RM)    $(CSSFILE)
	$(RM) -r $(CHUNK_DIR)
	$(RM)    index.html
	$(RM)    $(DOCNAME).html
	$(RM)    $(DOCNAME).fo
	$(RM)    $(DOCNAME)_tidy.fo
	$(RM)    $(DOCNAME).pdf
	$(RM)     *~
