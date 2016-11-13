# Description:
#   Responds to google-related commands
#
# Commands:
#   ~google - Responds with a link to google
#   ~google( .*) - Responds with a google search link
#
# Author:
#   josegonzalez

module.exports = (robot) ->
  robot.hear /~google( .*)?/i, (res) ->
    if res.match.input == '~google'
      res.reply "Google is a great place to find more information on this subject ( http://google.com )"
    else
      query = res.match[1].trim().split(' ').join('%20')
      res.reply "To see your query go here: http://www.google.com/search?q=#{query}"
