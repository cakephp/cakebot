# Description:
#   Send all chat logs to Elastic Search
#
# Dependencies:
#   None
#
# Configuration:
#   None
#

# Setup Elastic Search Client
ElasticSearchClient = require('elasticsearchclient')
elasticSearchClient = new ElasticSearchClient({
    host: "127.0.0.1",
    port: 9200
})

# Index configuration
config = {
    number_of_shards: 4,
    number_of_replicas: 1,
    analysis: {
        analyzer: {
            indexAnalyzer: {
                type: 'custom',
                tokenizer: 'standard',
                filter: ['lowercase', 'mySnowball']
            }
            searchAnalyzer: {
                type: 'custom',
                tokenizer: 'standard',
                filter: ['standard', 'lowercase', 'mySnowball']
            }
        },
        filter: {
            mySnowball: {
                type: 'snowball',
                language: 'english'
            }
        }
    }
}

# Generic onError callback
onError = (data) ->
    console.log JSON.parse(data)

# Generic onDone callback
onDone = ->
    console.log "done"

# Generic onData callback
onData = (data) ->
    console.log JSON.parse(data)

# Create index
elasticSearchClient
    .createIndex("messages", config)
    .on('data', onData)
    .on('done', onDone)
    .on('error', onError)
    .exec()

# Create mapping "entry" to ”messages" index
elasticSearchClient
    .putMapping("messages", "entry", {
        entry: {
          properties: {
            Channel: {
              properties: {
                room: {
                  type: 'string',
                  include_in_all: true,
                  index: "not_analyzed"
                },
                user: {
                    type: 'string',
                    include_in_all: true
                },
                message: {
                    type: 'string',
                    include_in_all: true
                },
                timestamp: {
                    type: 'date',
                    include_in_all: true,
                    format: "yyyy-MM-dd"
                }
              }
            }
          }
        }
    })
    .on('data', onData)
    .on('done', onDone)
    .on('error', onError)
    .exec()

module.exports = (robot) ->
    robot.hear /.*$/i, (msg) ->
        return if typeof msg.message.user.id == 'undefined'

        elasticSearchClient
            .index("messages", "entry", {
              Channel: {
                room        : msg.message.user.room,
                user        : msg.message.user.name
                message     : msg.message.text
                timestamp   : new Date
              }
            })
            .on('error', onError)
            .exec()

