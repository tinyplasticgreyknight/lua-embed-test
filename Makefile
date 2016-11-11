HOST=luahost
LIB=versiontest

BUILDDIR=build

MODE=debug

EXTBIN=
EXTLIB=.so
PREFLIB=lib

HOSTFILE=$(HOST)$(EXTBIN)
LIBFILE=$(LIB)$(EXTLIB)
PLIBFILE=$(PREFLIB)$(LIBFILE)
HOSTDIR=$(HOST)/target/$(MODE)
LIBDIR=$(LIB)/target/$(MODE)

COPY=cp
REMOVE=rm
MKDIR=mkdir

all: $(BUILDDIR)/$(HOSTFILE) $(BUILDDIR)/$(LIBFILE)

run: all
	(cd $(BUILDDIR); ./$(HOSTFILE))

clean:
	-$(REMOVE) $(BUILDDIR)/*

spotless: clean
	-$(REMOVE) *~
	-$(REMOVE) */*~
	-$(REMOVE) */src/*~
	-$(REMOVE) */target/*~

$(BUILDDIR):
	$(MKDIR) $(BUILDDIR)

$(BUILDDIR)/$(HOSTFILE): $(HOSTDIR)/$(HOSTFILE) $(BUILDDIR)
	$(COPY) $< $@

$(BUILDDIR)/$(LIBFILE): $(LIBDIR)/$(PLIBFILE) $(BUILDDIR)
	$(COPY) $< $@

$(HOSTDIR)/$(HOSTFILE): $(shell find $(HOST)/src -name '*.rs')
	(cd $(HOST); cargo build)

$(LIBDIR)/$(PLIBFILE): $(shell find $(LIB)/src -name '*.rs')
	(cd $(LIB); cargo build)
