# Description:
#   Responds to tilda (~) and bang (!) commands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~api                        - Responds with a link to api.cakephp.org
#   ~bin                        - Responds with a link to gist.github.com
#   ~book                       - Responds with a link to the book
#   ~book (.*)                  - Responds with a book search link
#   ~gist                       - Responds with a link to gist.github.com
#   ~google                     - Responds with a link to google
#   ~google (.*)                - Responds with a google search link
#   ~issues                     - Responds with a link to the issue tracker
#   ~issues( .*)                - Responds with a book search link
#   ~php (.*)                   - Responds with a php function link
#   ~slap                       - Slaps you
#   ~slap                       - Slaps a user
#   ~tell ([^\s\\]+) about (.*) - Tells a user about a topic
#   ~([^\s\\]+)                 - Outputs the contents of a topic
#
# Todo:
#   ~api (.*) - Responds with a link to a class that matched via fuzzy search
#
# Author:
#   josegonzalez
#

mysql = require('mysql');

# setup callbacks and helper methods
onConnect = (err, connection) ->
  if (err)
    console.log('Unable to connect: ' + err)

# setup mysql client
DATABASE_URL = process.env.DATABASE_URL || 'mysql://username:password@localhost:3306/cakebot'
DATABASE_URL = DATABASE_URL + "?connectionLimit=10"
pool  = mysql.createPool(DATABASE_URL);
pool.getConnection(onConnect)

module.exports = (robot) ->
  robot.hear /^([~!])([^\s\\]+)( .*)?/i, (msg) ->
    command = msg.match[2]
    text = msg.match[3]
    text = text.trim() if text?

    if command == 'api'
      if text?
        robot.logger.warning "Not yet implemented"
        # This API may have this at $url
      else
        msg.reply "This API is an incredible resource which you can find at http://api.cakephp.org."
    else if command == 'bin'
      msg.reply "Please paste some code in here ----> https://gist.github.com/ then post the url in the channel."
    else if command == 'gist'
      msg.reply "Please paste some code in here ----> https://gist.github.com/ then post the url in the channel."
    else if command == 'book'
      if text?
        query = text.split(' ').join('+')
        msg.reply "http://book.cakephp.org/search/#{query}"
      else
        msg.reply "Book is http://book.cakephp.org the answer to life, the universe and all your bun making needs."
    else if command == 'google'
      if text?
        query = text.split(' ').join('%20')
        msg.reply "To see your query go here: https://www.google.com/search?q=#{query}"
      else
        msg.reply "Google is a great place to find more information on this subject ( https://google.com )"
    else if command == 'issues'
      if text?
        query = text.split(' ').join(' ')
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
      else
        msg.reply "Submit your issue here: https://github.com/cakephp/cakephp/issues"
    else if command == 'php'
      if text?
        msg.reply "For more info on #{text} go to https://secure.php.net/#{text}"
      else
        msg.reply "Please specify a php function to lookup"
    else if command == 'slap'
      if text?
        msg.send "/me slaps #{text} with a large trout"
      else
        msg.send "/me slaps #{msg.message.user.name} for being a dumbass (Copyrighted by ADmad)"
    else
      tell = null
      username = null
      if command == 'tell' and text?
        matches = text.match /([^\s\\]+) about (.*)/i
        username = matches[1] if matches
        tell = matches[2] if matches
      else
        tell = "#{command}"

      if tell
        getTell = (err, results) ->
          prefix = ""
          prefix = "#{username}: " if username

          if err
            msg.send "Unable to retrieve tell"
          else if results.length == 0
            msg.send "#{prefix}I don't know enough about #{tell}"
          else
            msg.send "#{prefix}#{results[0].keyword} is #{results[0].message}"
        pool.query('SELECT * FROM tells WHERE keyword = ? LIMIT 1', [tell], getTell)
