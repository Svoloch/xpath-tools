.PHONY: all test clear demo old
all: es6 web userscript
old: core.coffee utils.coffee extra-utils.coffee events.coffee off.coffee hl.coffee
	cat core.coffee utils.coffee extra-utils.coffee events.coffee off.coffee hl.coffee | coffee -csb > xpath.js
es6: dist/es6/core.js dist/es6/utils.js dist/es6/extra-utils.js dist/es6/events.js dist/es6/events-send.js dist/es6/off.js dist/es6/hl.js dist/es6/xpath.js
web: dist/web/core.js dist/web/utils.js dist/web/extra-utils.js dist/web/events.js dist/web/events-send.js dist/web/off.js dist/web/hl.js dist/web/xpath.js
userscript: dist/xpath-userscript.js
clear:
	rm dist/es6/core.js
	rm dist/es6/utils.js
	rm dist/es6/extra-utils.js
	rm dist/es6/events.js
	rm dist/es6/events-send.js
	rm dist/es6/off.js
	rm dist/es6/hl.js
	rm dist/es6/xpath.js
	rm dist/web/core.js
	rm dist/web/utils.js
	rm dist/web/extra-utils.js
	rm dist/web/events.js
	rm dist/web/events-send.js
	rm dist/web/off.js
	rm dist/web/hl.js
	rm dist/web/xpath.js
	rm dist/xpath-userscript.js

dist/web/core.js: src/core.coffee
	grep -v -P "###\!IMPORT###" src/core.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/core.js
dist/web/utils.js: src/utils.coffee
	grep -v -P "###\!IMPORT###"  src/utils.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/utils.js
dist/web/extra-utils.js: src/extra-utils.coffee
	grep -v -P "###\!IMPORT###"  src/extra-utils.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/extra-utils.js
dist/web/events.js: src/events.coffee
	grep -v -P "###\!IMPORT###"  src/events.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/events.js
dist/web/events-send.js: src/events-send.coffee
	grep -v -P "###\!IMPORT###"  src/events-send.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/events-send.js
dist/web/off.js: src/off.coffee
	grep -v -P "###\!IMPORT###"  src/off.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/off.js
dist/web/hl.js: src/hl.coffee
	grep -v -P "###\!IMPORT###"  src/hl.coffee | sed "s/###\!SCRIPT###//g"| coffee -csb > dist/web/hl.js
dist/web/xpath.js: dist/web/core.js dist/web/utils.js dist/web/extra-utils.js dist/web/events.js dist/web/events-send.js dist/web/off.js dist/web/hl.js
	cat dist/web/core.js dist/web/utils.js dist/web/extra-utils.js dist/web/events.js dist/web/events-send.js dist/web/off.js dist/web/hl.js > dist/web/xpath.js

dist/es6/core.js: src/core.coffee
	grep -v -P "###\!SCRIPT###"  src/core.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/core.js
dist/es6/utils.js: src/utils.coffee
	grep -v -P "###\!SCRIPT###" src/utils.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/utils.js
dist/es6/extra-utils.js: src/extra-utils.coffee
	grep -v -P "###\!SCRIPT###" src/extra-utils.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/extra-utils.js
dist/es6/events.js: src/events.coffee
	grep -v -P "###\!SCRIPT###" src/events.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/events.js
dist/es6/events-send.js: src/events-send.coffee
	grep -v -P "###\!SCRIPT###" src/events-send.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/events-send.js
dist/es6/off.js: src/off.coffee
	grep -v -P "###\!SCRIPT###" src/off.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/off.js
dist/es6/hl.js: src/hl.coffee
	grep -v -P "###\!SCRIPT###" src/hl.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/hl.js
dist/es6/xpath.js: src/xpath.coffee
	grep -v -P "###\!SCRIPT###"  src/xpath.coffee | sed "s/###\!IMPORT###//g"| coffee -csb > dist/es6/xpath.js

dist/xpath-userscript.js: dist/web/xpath.js src/userscript-header.js
	cat src/userscript-header.js dist/web/xpath.js > dist/xpath-userscript.js
