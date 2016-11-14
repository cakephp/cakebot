# Description:
#   Responds to google-related commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~google - Responds with a link to google
#   ~google( .*) - Responds with a google search link
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /~google( .*)?/i, (msg) ->
    if msg.match.input == '~google'
      msg.reply "Google is a great place to find more information on this subject ( https://google.com )"
    else
      query = msg.match[1].trim().split(' ').join('%20')
      msg.reply "To see your query go here: https://www.google.com/search?q=#{query}"
