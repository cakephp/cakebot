# Description:
#   Responds to book-related commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~book - Responds with a link to the book
#   ~book( .*) - Responds with a book search link
#
# Author:
#   josegonzalez
#

module.exports = (robot) ->
  robot.hear /~book( .*)?/i, (res) ->
    if res.match.input == '~book'
      res.reply "Book is http://book.cakephp.org the answer to life, the universe and all your bun making needs."
    else
      query = res.match[1].trim().split(' ').join('+')
      res.reply "http://book.cakephp.org/search/#{query}"
