JNI_LOCAL_PATH := $(call my-dir)

BUILD_VARIANT := debug

ifeq ($(NDK_DEBUG), 1)
    BUILD_VARIANT := release
endif

#SDL2
include $(CLEAR_VARS)
LOCAL_MODULE := SDL2
LOCAL_SRC_FILES := $(JNI_LOCAL_PATH)/../ndkLibs/libs/$(BUILD_VARIANT)/$(TARGET_ARCH_ABI)/libSDL2.so
LOCAL_EXPORT_C_INCLUDES := $(JNI_LOCAL_PATH)/../ndkLibs/SDL2/include/
include $(PREBUILT_SHARED_LIBRARY)

#PNG
include $(CLEAR_VARS)
LOCAL_MODULE := png
LOCAL_SRC_FILES := $(JNI_LOCAL_PATH)/../ndkLibs/libs/$(BUILD_VARIANT)/$(TARGET_ARCH_ABI)/libpng.a
LOCAL_EXPORT_C_INCLUDES := $(JNI_LOCAL_PATH)/../ndkLibs/png/
LOCAL_EXPORT_LDLIBS := -lz
include $(PREBUILT_STATIC_LIBRARY)

#Freetype
include $(CLEAR_VARS)
LOCAL_MODULE := freetype
LOCAL_SRC_FILES := $(JNI_LOCAL_PATH)/../ndkLibs/libs/$(BUILD_VARIANT)/$(TARGET_ARCH_ABI)/libfreetype.so
LOCAL_EXPORT_C_INCLUDES := $(JNI_LOCAL_PATH)/../ndkLibs/freetype/include/
include $(PREBUILT_SHARED_LIBRARY)

M64P_API_INCLUDES := $(JNI_LOCAL_PATH)/../mupen64plus-core/upstream/src/api/
GL_INCLUDES := $(JNI_LOCAL_PATH)/../ndkLibs/GL

COMMON_CFLAGS :=                    \
    -O3                             \
    -ffast-math                     \
    -fno-strict-aliasing            \
    -fomit-frame-pointer            \
    -fvisibility=hidden

COMMON_CPPFLAGS :=                  \
    -fvisibility-inlines-hidden     \
    -O3                             \
    -ffast-math                     \

COMMON_LDFLAGS :=

#ifneq ($(HOST_OS),windows)
#    COMMON_CFLAGS += -flto
#    COMMON_LDFLAGS +=                   \
#        $(COMMON_CFLAGS)                \
#        $(COMMON_CPPFLAGS)
#endif

BASE_DIR := upstream

include $(JNI_LOCAL_PATH)/upstream/src/osal/mupen64plus-video-osal.mk
include $(JNI_LOCAL_PATH)/upstream/src/GLideNHQ/mupen64plus-video-glidenhq.mk
include $(JNI_LOCAL_PATH)/upstream/src/mupen64plus-video-gliden64.mk
