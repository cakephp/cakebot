# Description:
#   Responds to api-related commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~api - Responds with a link to api.cakephp.org
#
# Todo:
#   ~api( .*) - Responds with a link to a class that matched via fuzzy search
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /^~api( .*)?/i, (msg) ->
    if msg.match.input == '~api'
      msg.reply "This API is an incredible resource which you can find at http://api.cakephp.org."
    else
      robot.logger.warning "Not yet implemented"
      # This API may have this at $url
