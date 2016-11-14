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

module.exports = (robot) ->
  robot.respond /rollover/i, (msg) ->
    msg.send "/me plays dead"
