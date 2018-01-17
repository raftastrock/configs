'use strict'

import downloadBundles from './src/downloadBundles.mjs'
import rewritePort from './src/rewritePort.mjs'

rewritePort()
downloadBundles()
