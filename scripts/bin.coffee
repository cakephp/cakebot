# Description:
#   Responds to bin-related commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~bin - Responds with a link to gist.github.com
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /^~bin/i, (msg) ->
    msg.reply "Please paste some code in here ----> https://gist.github.com/ then post the url in the channel."

  robot.hear /^~gist/i, (msg) ->
    msg.reply "Please paste some code in here ----> https://gist.github.com/ then post the url in the channel."
