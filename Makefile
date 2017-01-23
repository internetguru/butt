#-------------------------------------------------------------------------------
# Variables to setup through environment
#-------------------------------------------------------------------------------

# Specify default values.
prefix       := /usr/local
destdir      :=
system       := cygwin
# Fallback to defaults but allow to get the values from environment.
PREFIX       ?= $(prefix)
EXEC_PREFIX  ?= $(PREFIX)
DESTDIR      ?= $(destdir)
SYSTEM       ?= $(system)

#-------------------------------------------------------------------------------
# Installation paths
#-------------------------------------------------------------------------------

DIRNAME     := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
RST2MAN     := rst2man
PROG        := butt
PROGSINGLE  := butt.sh
DATAPATHVAR := BUTT_DATAPATH
USAGEVAR    := BUTT_USAGE
VERSIONVAR  := BUTT_VERSION
README      := README
MANFILE     := $(PROG).1
USAGEFILE   := $(PROG).usage
VERFILE     := VERSION
CHLOGFILE   := CHANGELOG.md
TAPLIB      := libtap.sh
DESTPATH    := $(DESTDIR)$(PREFIX)
BINPATH     := $(DESTDIR)$(EXEC_PREFIX)/bin
SHAREPATH   := $(DESTPATH)/share
MANDIR      := man/man1
DISTNAME    := $(PROG)-$$(cat $(VERFILE))-$(SYSTEM)
TMPDIR      := compiled
INSTFILE    := install
INSDEVTFILE := install_develop
UNINSTFILE  := uninstall
USAGEHEADER := "Usage: "

#-------------------------------------------------------------------------------
# Canned recipes
#-------------------------------------------------------------------------------

define compile_usage
	@echo -n "Compiling usage file ..."
	@echo -n "$(USAGEHEADER)" > $(TMPDIR)/$(USAGEFILE)
	@grep "^$(PROG) \[" $(README).rst | sed 's/\\|/|/g' >> $(TMPDIR)/$(USAGEFILE)
	@echo ".TH" >> $(TMPDIR)/$(USAGEFILE)
	@sed -n '/^OPTIONS/,/^INSTALL/p' $(README).rst  | grep -v "^\(INSTALL\|OPTIONS\|======\)" \
	| sed 's/^\\/-/;s/^-/.TP 18\n-/' | sed 's/^    //' | sed '/^$$/d' >> $(TMPDIR)/$(USAGEFILE)
	@echo DONE
endef

#-------------------------------------------------------------------------------
# Recipes
#-------------------------------------------------------------------------------

compile:
	@ mkdir -p $(TMPDIR)
	@ cp $(VERFILE) $(CHLOGFILE) $(TMPDIR)

	@ echo -n "Compiling command file ..."
	@ { \
	head -n1 $(PROG); \
	echo "$(DATAPATHVAR)=\"$(SHAREPATH)/$(PROG)\""; \
	tail -n+2 $(PROG); \
	} > $(TMPDIR)/$(PROG)
	@ chmod +x $(TMPDIR)/$(PROG)
	@ echo DONE

	@ echo -n "Compiling man file ..."
	@ { \
	echo -n ".TH \"$(PROG)\" \"1\" "; \
	echo -n "\""; echo -n $$(stat -c %z $(README).rst | cut -d" " -f1); echo -n "\" "; \
	echo -n "\"User Manual\" "; \
	echo -n "\"Version "; echo -n $$(cat $(VERFILE)); echo -n "\" "; \
	echo; \
	} > $(TMPDIR)/$(MANFILE)
	@ cat $(README).rst | sed -n '/^NAME/,/^INSTALL/p;/^EXIT STATUS/,//p' $(README).rst | grep -v "^INSTALL" | sed 's/`\(.*\)<\(.*\)>`__/\1\n\t\2/g' | $(RST2MAN) | tail -n+8 >> $(TMPDIR)/$(MANFILE)
	@ echo DONE

	@ echo -n "Compiling readme file ..."
	@ cp $(README).rst $(TMPDIR)/$(README).rst
	@ echo DONE

	$(compile_usage)

	@ echo -n "Compiling install file ..."
	@ { \
	echo "#!/bin/bash"; \
	echo; \
	echo ": \$${BINPATH:=$(BINPATH)}"; \
	echo ": \$${SHAREPATH:=$(SHAREPATH)}"; \
	echo ": \$${USRMANPATH:=\$$SHAREPATH/$(MANDIR)}"; \
	echo; \
	echo "dir=\"\$$(dirname \"\$$0\")\""; \
	echo "mkdir -p \"\$$USRMANPATH\" \\"; \
	echo "&& cp \"\$$dir/$(MANFILE)\" \"\$$USRMANPATH\" \\"; \
	echo "&& mkdir -p \"\$$BINPATH\" \\"; \
	echo "&& cp \"\$$dir/$(PROG)\" \"\$$BINPATH\" \\"; \
	echo "&& mkdir -p \"\$$SHAREPATH/$(PROG)\" \\"; \
	echo "&& cp -r \"$(TAPLIB)\" \"\$$dir/$(USAGEFILE)\" \"\$$dir/$(VERFILE)\" \"\$$SHAREPATH/$(PROG)\" \\"; \
	echo "&& echo 'Installation completed.' \\"; \
	echo "|| { echo 'Installation failed.'; exit 1; }"; \
	} > $(TMPDIR)/$(INSTFILE)
	@ chmod +x $(TMPDIR)/$(INSTFILE)
	@ echo DONE

	@ echo -n "Compiling uninstall file ..."
	@ { \
	echo "#!/bin/bash"; \
	echo; \
	echo ": \$${BINPATH:=$(BINPATH)}"; \
	echo ": \$${SHAREPATH:=$(SHAREPATH)}"; \
	echo ": \$${USRMANPATH:=\$$SHAREPATH/$(MANDIR)}"; \
	echo; \
	echo "rm \"\$$USRMANPATH/$(MANFILE)\""; \
	echo "rm \"\$$BINPATH/$(PROG)\""; \
	echo "rm -rf \"\$$SHAREPATH/$(PROG)\""; \
	echo "echo 'Uninstallation completed.'"; \
	} > $(TMPDIR)/$(UNINSTFILE)
	@ chmod +x $(TMPDIR)/$(UNINSTFILE)
	@ echo DONE

dist: TMPDIR=$(DISTNAME)
dist: compile
	@ tar czf $(TMPDIR).tar.gz $(TMPDIR)
	@ echo "Distribution built; see 'tar tzf $(TMPDIR).tar.gz'"

distsingle:
	@ mkdir -p $(TMPDIR)

	@ $(compile_usage)

	@ echo -n "Compiling single script ..."
	@ { \
	head -n1 $(PROG); \
	echo "$(USAGEVAR)=\"$$(cat $(TMPDIR)/$(USAGEFILE))\""; \
	echo "$(VERSIONVAR)=\"$$(cat $(VERFILE))\""; \
	tail -n+2 $(PROG); \
	} > $(TMPDIR)/$(PROGSINGLE)
	# replace line like "#replaceline# source.sh" with content of source.sh
	@ awk '/#replaceline#/{ system("cat " $$NF); next } {print}' $(TMPDIR)/$(PROGSINGLE) > $(TMPDIR)/$(PROGSINGLE).tmp
	@ mv $(TMPDIR)/$(PROGSINGLE).tmp $(TMPDIR)/$(PROGSINGLE)
	@ chmod +x $(TMPDIR)/$(PROGSINGLE)
	@ echo DONE

clean:
	@ rm -rf $(TMPDIR)
	@ rm -rf $(DISTNAME)
	@ rm -rf *.tar.gz
