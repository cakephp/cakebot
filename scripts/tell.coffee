# Description:
#   Tell Hubot to send a user a message when present in the room
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot tell <username> <some message> - tell <username> <some message> next time they are present
#   hubot message <username> - check wether <username> has undelivered message
#
# Author:
#   christianchristensen

module.exports = (robot) ->
   if robot.brain.data.messages == undefined
     robot.brain.data.messages = {}
   localstorage = robot.brain.data.messages

   robot.respond /tell ([\w.-]*) (.*)/i, (msg) ->
     localstorage = robot.brain.data.messages
     datetime = new Date()
     key = msg.match[1].toLowerCase() + msg.message.user.room
     tellmessage = msg.match[1] + ": " + msg.message.user.name + " @ " + datetime.toTimeString() + " said: " + msg.match[2] + "\r\n"
     if localstorage[key] == undefined
       localstorage[key] = tellmessage
     else
       localstorage[key] += tellmessage
     msg.send "sure, i'll tell " + msg.match[1] + " about it"
     robot.brain.mergeData({messages: localstorage})
     return

   robot.respond /messages( )?([\w.-]*)/i, (msg) ->
     localstorage = robot.brain.data.messages
     if msg.match[2] == ''
       tellmessage = "Whose message?"
     else
       key = msg.match[2].toLowerCase() + msg.message.user.room
       if localstorage[key] != undefined
         tellmessage = "I still have the message for " + msg.match[2]
       else
         tellmessage = "No message left for " + msg.match[2]
     msg.send tellmessage
     return

   robot.enter (msg) ->
     localstorage = robot.brain.data.messages
     key = msg.message.user.name.toLowerCase() + msg.message.user.room
     if localstorage[key] != undefined
       tellmessage = localstorage[key]
       delete localstorage[key]
       msg.send tellmessage
     return

   robot.hear /./i, (msg) ->
     localstorage = robot.brain.data.messages
     key = msg.message.user.name.toLowerCase() + msg.message.user.room
     if localstorage[key] != undefined
       tellmessage = localstorage[key]
       delete localstorage[key]
       msg.send tellmessage
     return
