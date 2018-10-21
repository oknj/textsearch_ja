MODULE_big = textsearch_ja
OBJS = textsearch_ja.o encoding_eucjp.o encoding_utf8.o pgut/pgut-be.o
SHLIB_LINK = -lmecab
REGRESS = init convert textsearch_ja

EXTENSION = textsearch_ja
DATA = textsearch_ja--42.sql textsearch_ja--9.6--42.sql textsearch_ja--9.5--9.6.sql textsearch_ja--9.4--9.5.sql

ifndef USE_PGXS
top_builddir = ../..
makefile_global = $(top_builddir)/src/Makefile.global
ifeq "$(wildcard $(makefile_global))" ""
USE_PGXS = 1	# use pgxs if not in contrib directory
endif
endif

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/$(MODULE_big)
include $(makefile_global)
include $(top_srcdir)/contrib/contrib-global.mk
endif

# remove dependency to libxml2 and libxslt
LIBS := $(filter-out -lxml2, $(LIBS))
LIBS := $(filter-out -lxslt, $(LIBS))
