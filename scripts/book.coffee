robot.hear /~book/i, (res) ->
  res.reply "Book is http://book.cakephp.org the answer to life, the universe and all your bun making needs."

robot.hear /~book (.*)/i, (res) ->
  query = res.match[1].split(' ').join('+')
  res.reply "http://book.cakephp.org/search/#{query}"
