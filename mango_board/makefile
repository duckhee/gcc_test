######################################
# target
######################################
TARGET = empty_makefile


######################################
# building variables
######################################
# debug build?
DEBUG = 1
#optimization
OPT = -Og

#######################################
# paths
#######################################
# Build path
BUILD_DIR = build


######################################
# source
######################################
include source.mk

#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-

# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.

ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
OBJDUMP = $(GCC_PATH)/$(PREFIX)objdump
OBJNM = $(GCC_PATH)/$(PREFIX)nm
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
DUMP = $(PREFIX)objdump
OBJNM = $(PREFIX)nm
SZ = $(PREFIX)size
endif

HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m3

# fpu
# NONE for Cortex-M0/M0+/M3
FPU = 

# float-abi
FLOAT-ABI = 

# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

#define 
include def.mk

#include header 
include inc.mk

ASFLAGS = $(MCU) $(AS_DEF) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEF) $(C_INCLUDES) $(OPT) -Wall -fdata-section --ffunction-sections
#need to test
EXTRAINCDIRS = $(patsubst %,-I%,$(EXTRAC_INCLUDES))
#CFLAGS = $(MCU) $(C_DEF) $(EXTRAINCDIRS) $(OPT) -Wall -fdata-section --ffunction-sections
CFLAGS += -fdata-sections -Wall -Wextra -Wimplicit -Wcast-align -Wpointer-arith -Wredundant-decls -Wshadow -Wcast-qual -Wcast-align
CFLAGS += -g -gdwarf-2 -u _printf_float -u _scanf_float

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif

# Generate dependency information
CFLAGS += -MMD -MP -MF"$(:%.o=%.d)"

#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = STM32F103RBTx_FLASH.ld

#libraries
LIBS = -lc -lm -lnosys
LIBDIR = 

LDFLAGS = $(MCU) -specs=nano.spes -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

include message.mk



# default action: build all
all:$(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin $(BUILD_DIR)/$(TARGET).lss $(BUILD_DIR)/$(TARGET).sym gccversion


gccversion:
	$(CC) --version


#######################################
# build the application
#######################################
# list of objects
OBJETCTS = $(addprefix $(BUILD_DIR)/, $(notdir $(C_SOURCES:.c=.0)))
vpath %.c $(sort $(dir $(C_SOURCES)))
#list of ASM program objects
OBJETCTS += $(addprefix $(BUILD_DIR)/, $(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	@echo $(MSG_LOAD_FILE) $@
	$(CC) -c $(CFLAGS) -Wa,a,-ad,alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	@echo $(MSG_ASMFROMC) $@
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJETCTS) Makefile
	@echo $(MSG_LINKING) $@
	$(CC) $(OBJETCTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/%.elf |$(BUILD_DIR)
	@echo $(MSG_LOAD_FILE) $@
	$(HEX) $< $@

$(BUILD_DIR)/$(TARGET)/bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@echo $(MSG_LOAD_FILE) $@
	$(BIN) $< $@

$(BUILD_DIR):
	mkdir $@

$(BUILD_DIR)/$(TARGET).sym:$(BUILD_DIR)/%.elf |$(BUILD_DIR)
	@echo $(MSG_SYMBOL_TABLE) $@
	$(NM) -n $< > $@

$(BUILD_DIR)/$(TARGET).lss:$(BUILD_DIR)/%.elf |$(BUILD_DIR)
	@echo $(MSG_EXTENDED_LISTING) $)
	$(OBJDUMP) -h -S -C -r $< > $@

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)

  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
