#CROSS_COMPILE?=arm-arago-linux-gnueabi-

LIBDIR_APP_LOADER?=lib
INCDIR_APP_LOADER?=include
BINDIR?=bin

CFLAGS+= -Wall -I$(INCDIR_APP_LOADER) -D__DEBUG -O2 -mtune=cortex-a8 -march=armv7-a
LDFLAGS+=-L$(LIBDIR_APP_LOADER) -lprussdrv -lpthread
OBJDIR=obj
TARGET=$(BINDIR)/dmx

_DEPS = 
DEPS = $(patsubst %,$(INCDIR_APP_LOADER)/%,$(_DEPS))

_OBJ = dmx.o
OBJ = $(patsubst %,$(OBJDIR)/%,$(_OBJ))


$(OBJDIR)/%.o: %.c $(DEPS)
	@mkdir -p obj
	$(CROSS_COMPILE)gcc $(CFLAGS) -c -o $@ $< 

$(TARGET): $(OBJ)
	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ $^ $(LDFLAGS)

.PHONY: clean

clean:
	rm -rf $(OBJDIR)/ *~  $(INCDIR_APP_LOADER)/*~  $(TARGET)
