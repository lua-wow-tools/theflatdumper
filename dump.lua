local s = require('scrapelib').parseSavedVariables(arg[1]).Data
require('pl.pretty').dump(s)
