# Description:
#   Responds to php-related commands
#
# Commands:
#   ~php( .*) - Responds with a php function link
#
# Author:
#   josegonzalez

module.exports = (robot) ->
  robot.hear /~php( .*)?/i, (res) ->
    if res.match.input == '~php'
      res.reply "Please specify a php function to lookup"
    else
      func = res.match[1].trim()
      res.reply "For more info on #{func} go to https://secure.php.net/#{func}"
