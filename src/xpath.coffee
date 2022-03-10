
import XPath from "./core.js"
import events from "./events.js"
import eventsSend from "./events-send.js"
import utils from "./utils.js"
import ectraUtils from "./extra-utils.js"
import off_ from "./off.js"
import hl from "./hl.js"
XPath.use(
	events
	eventsSend
	utils
	ectraUtils
	off_
	hl
)
export default XPath
