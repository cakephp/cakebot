# Description:
#   Responds to issue-related commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~issues - Responds with a link to the issue tracker
#   ~issues( .*) - Responds with a book search link
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /~issues( .*)?/i, (msg) ->
    if msg.match.input == '~issues'
      msg.reply "Submit your issue here: https://github.com/cakephp/cakephp/issues"
    else
      query = msg.match[1].trim().split(' ').join(' ')
      robot.http("https://api.github.com/search/issues?sort=created&order=asc&q=repo:cakephp/cakephp+" + query)
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          if res.statusCode isnt 200
            msg.reply "Request didn't come back HTTP 200 :("
            return

          data = JSON.parse body
          if data.items.length == 0
            msg.reply "No issues found."
          else if data.items.length == 1
            msg.reply "1 ticket found. To see the ticket go to: " + data.items[0].html_url
          else
            msg.reply data.total_count + " tickets found. To see the tickets go to: https://github.com/cakephp/cakephp/search?type=Issues&q=" + query
