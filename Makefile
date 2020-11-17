EXECUTABLE_NAME = toolkit

BUILD_PATH_RELEASE = Tools/Toolkit/.build/release
EXECUTABLE_PATH_RELEASE = $(BUILD_PATH_RELEASE)/Toolkit

BUILD_PATH_DEBUG = Tools/Toolkit/.build/debug
EXECUTABLE_PATH_DEBUG= $(BUILD_PATH_DEBUG)/Toolkit

clean:
	rm -rf Tools/Toolkit/.build $(EXECUTABLE_NAME)

build: clean
	swift build -c release --disable-sandbox --arch x86_64 --package-path Tools/Toolkit
	ln -s $(EXECUTABLE_PATH_RELEASE) $(EXECUTABLE_NAME)

build-debug:
	if [ -f $(EXECUTABLE_NAME) ]; then rm $(EXECUTABLE_NAME); fi

	swift build --package-path Tools/Toolkit
	ln -s $(EXECUTABLE_PATH_DEBUG) $(EXECUTABLE_NAME)

gen-docs: 
	./$(EXECUTABLE_NAME) generate-documentation