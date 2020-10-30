EXECUTABLE_NAME = toolkit
BUILD_PATH = Tools/Toolkit/.build/release
EXECUTABLE_PATH = $(BUILD_PATH)/Toolkit

clean:
	rm -rf Tools/Toolkit/.build $(EXECUTABLE_NAME)

build: clean
	swift build -c release --disable-sandbox --arch x86_64 --package-path Tools/Toolkit
	ln -s $(EXECUTABLE_PATH) $(EXECUTABLE_NAME)

gen-docs: 
	./$(EXECUTABLE_NAME) generate-documentation ./
	


