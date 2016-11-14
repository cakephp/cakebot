# Description:
#   Slaps a user
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   slap - Slaps a user
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /~slap (.*)?/i, (msg) ->
    if msg.match.input == '~slap'
      msg.send "/me slaps #{msg.message.user.name} for being a dumbass (Copyrighted by ADmad)"
    else
      username = msg.match[1]
      msg.send "/me slaps #{username} with a large trout"
