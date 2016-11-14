# Description:
#   Plays dead
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rollover - Plays dead
#
# Author:
#   josegonzalez
#

url = require("url")

module.exports = (robot) ->
  robot.respond /rollover/i, (msg) ->
    msg.send "/me plays dead"
