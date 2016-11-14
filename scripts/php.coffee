# Description:
#   Responds to php-related commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~php( .*) - Responds with a php function link
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /~php( .*)?/i, (msg) ->
    if msg.match.input == '~php'
      msg.reply "Please specify a php function to lookup"
    else
      func = msg.match[1].trim()
      msg.reply "For more info on #{func} go to https://secure.php.net/#{func}"
