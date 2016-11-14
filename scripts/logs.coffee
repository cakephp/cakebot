# Description:
#   Send all chat logs to MySQL
#
# Dependencies:
#   None
#
# Configuration:
#   None
#

# define all channels
channels = {
  '#cakephp':        1,
  'cakebot':         2,
  '#cakephp-fr':     3,
  '#cakephp-bakery': 4,
  '#cakephp-nl':     5,
  'cakebot-dev':     6,
  'unknown':         7,
}


# setup callbacks and helper methods
onConnect = (err, connection) ->
  if (err)
    console.log('Unable to connect: ' + err)

channelId = (room) ->
  if channels.hasOwnProperty(room)
    channel_id = channels[room]
  else
    channel_id = 7
  return channel_id

# setup mysql client
DATABASE_URL = process.env.DATABASE_URL || 'mysql://username:password@localhost:3306/cakebot'
DATABASE_URL = DATABASE_URL + "?connectionLimit=50"

mysql = require('mysql');
pool  = mysql.createPool(DATABASE_URL);
pool.getConnection(onConnect)

module.exports = (robot) ->
  robot.hear /.*$/i, (msg) ->
    return if typeof msg.message.user.id == 'undefined'

    log = {
      channel_id  : channelId(msg.message.user.room.toLowerCase()),
      username    : msg.message.user.name
      text        : msg.message.text
      created     : new Date
    }

    onDone = (err, result) ->
      if (err)
        console.log('Unable to insert message (' + log + '): ' + err)

    query = pool.query('INSERT INTO logs SET ?', log, onDone)
