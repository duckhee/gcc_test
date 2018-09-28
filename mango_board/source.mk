ASM_SOURCES = \
Core/CM3/startup/gcc/startup_stm32f10x_md.s

CORE_SOURCES =\
Core/CM3/core_cm3.c \
Core/CM3/system_stm32f10x.c \

CMSIS_SOURCES = \
STM32F10x_StdPeriph_Driver/src/misc.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_adc.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_bkp.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_can.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_crc.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_dac.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_dbgmcu.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_dma.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_exti.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_flash.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_fsmc.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_i2c.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_iwdg.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_pwr.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_rtc.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_sdio.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_spi.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_tim.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_usart.c \
STM32F10x_StdPeriph_Driver/src/stm32f10x_wwdg.c \

USB_SOURCES = \
STM32_USB-FS-Device_Driver/src/usb_core.c \
STM32_USB-FS-Device_Driver/src/usb_init.c \
STM32_USB-FS-Device_Driver/src/usb_mem.c \
STM32_USB-FS-Device_Driver/src/usb_regs.c \

USER_SOURCES = \
Src/main.c \


C_SOURCES = $(CORE_SOURCES) $(CMSIS_SOURCES) $(USER_SOURCES)

