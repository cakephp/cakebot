# Description:
#   Responds to bin-related commands
#
# Commands:
#   ~bin - Responds with a link to gist.github.com
#
# Author:
#   josegonzalez

module.exports = (robot) ->
  robot.hear /~bin/i, (res) ->
    res.reply "Please paste some code in here ----> https://gist.github.com/ then post the url in the channel."

  robot.hear /~gist/i, (res) ->
    res.reply "Please paste some code in here ----> https://gist.github.com/ then post the url in the channel."
