PROJECT_NAME := Baiacu
BUILD_DIR := $(CURDIR)/build
PROJECT_DIR := $(CURDIR)
BUILD_PREFIX := $(BUILD_DIR)/$(PROJECT_NAME)

GODOT := godot
GODOT_EXPORT := $(GODOT) $(PROJECT_DIR)/project.godot --no-window --export
BUTLER := butler
BUTLER_PROJECT := gilzoide/baiacu

all: android web win32 win64 linux32 linux64 osx

build-dir:
	@mkdir -p $(BUILD_DIR)/web

# Build executables by export preset
%win32.exe: $(PROJECT_DIR)
	$(GODOT_EXPORT) "Windows x32" $@

%win64.exe: $(PROJECT_DIR)
	$(GODOT_EXPORT) "Windows x64" $@

%linux32.x86: $(PROJECT_DIR)
	$(GODOT_EXPORT) "Linux/X11 x32" $@

%linux64.x86_64: $(PROJECT_DIR)
	$(GODOT_EXPORT) "Linux/X11 x64" $@

%osx.zip: $(PROJECT_DIR)
	$(GODOT_EXPORT) "Mac OSX" $@

%.html: $(PROJECT_DIR)
	$(GODOT_EXPORT) "HTML5" $@

%.apk: $(PROJECT_DIR)
	$(GODOT_EXPORT) "Android" $@

win32: $(BUILD_PREFIX)_win32.exe | build-dir
win64: $(BUILD_PREFIX)_win64.exe | build-dir
linux32: $(BUILD_PREFIX)_linux32.x86 | build-dir
linux64: $(BUILD_PREFIX)_linux64.x86_64 | build-dir
osx: $(BUILD_PREFIX)_osx.zip | build-dir
android: $(BUILD_PREFIX)_android.apk
web: $(BUILD_DIR)/web/index.html | build-dir

# Zip the application
%.zip: $(ADDITIONAL_FILES)
	zip $@ -j $(basename $@).* $^

zip-win32: win32 $(BUILD_PREFIX)_win32.zip
zip-win64: win64 $(BUILD_PREFIX)_win64.zip
zip-linux32: linux32 $(BUILD_PREFIX)_linux32.zip
zip-linux64: linux64 $(BUILD_PREFIX)_linux64.zip
zip-osx: osx  # osx already outputs a zip file
zip-android: android  # android needs no zip, APK is fine
zip-web: web
	zip $(BUILD_PREFIX)_web.zip -j $(BUILD_DIR)/web/*

zip-all: zip-android zip-web zip-win32 zip-win64 zip-linux32 zip-linux64 zip-osx


# Push to itch.io using butler
push-win32: zip-win32
	$(BUTLER) push $(BUILD_PREFIX)_win32.zip $(BUTLER_PROJECT):win32

push-win64: zip-win64
	$(BUTLER) push $(BUILD_PREFIX)_win64.zip $(BUTLER_PROJECT):win64

push-linux32: zip-linux32
	$(BUTLER) push $(BUILD_PREFIX)_linux32.zip $(BUTLER_PROJECT):linux32

push-linux64: zip-linux64
	$(BUTLER) push $(BUILD_PREFIX)_linux64.zip $(BUTLER_PROJECT):linux64

push-osx: zip-osx
	$(BUTLER) push $(BUILD_PREFIX)_osx.zip $(BUTLER_PROJECT):osx

push-android: zip-android
	$(BUTLER) push $(BUILD_PREFIX)_android.apk $(BUTLER_PROJECT):android

push-web: zip-web
	$(BUTLER) push $(BUILD_PREFIX)_web.zip $(BUTLER_PROJECT):web

push-all: push-android push-web push-win32 push-win64 push-linux32 push-linux64 push-osx
