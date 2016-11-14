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
  robot.hear /~api( .*)?/i, (res) ->
    if res.match.input == '~api'
      res.reply "This API is an incredible resource which you can find at http://api.cakephp.org."
    else
      @robots.logger.warning "Not yet implemented"
      # This API may have this at $url
