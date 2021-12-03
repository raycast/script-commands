EXECUTABLE_NAME = toolkit

TOOLKIT_PATH = Tools/Toolkit
BUILD_PATH_RELEASE = $(TOOLKIT_PATH)/.build/release
EXECUTABLE_PATH_RELEASE = $(BUILD_PATH_RELEASE)/Toolkit

BUILD_PATH_DEBUG = $(TOOLKIT_PATH)/.build/debug
EXECUTABLE_PATH_DEBUG = $(BUILD_PATH_DEBUG)/Toolkit

clean:
	rm -rf $(TOOLKIT_PATH)/.build $(EXECUTABLE_NAME)

build: clean
	swift build -c release --disable-sandbox --package-path $(TOOLKIT_PATH)
	ln -s $(EXECUTABLE_PATH_RELEASE) $(EXECUTABLE_NAME)

build-debug:
	if [ -f $(EXECUTABLE_NAME) ]; then rm $(EXECUTABLE_NAME); fi

	swift build --package-path $(TOOLKIT_PATH)
	ln -s $(EXECUTABLE_PATH_DEBUG) $(EXECUTABLE_NAME)

gen-docs:
	./$(EXECUTABLE_NAME) generate-documentation

gen-docs-and-commit: gen-docs
	./$(TOOLKIT_PATH)/integration.sh commit_documentation

set-executable:
	./$(EXECUTABLE_NAME) set-executable

set-executable-and-commit: set-executable
	./$(TOOLKIT_PATH)/integration.sh commit_executable

lint:
	swiftlint lint

fix:
	swiftlint --fix

open:
	open -a /Applications/Xcode.app $(TOOLKIT_PATH)
