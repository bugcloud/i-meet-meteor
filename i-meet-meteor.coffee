if Meteor.is_client
  Template.hello.greeting = () ->
    "Input your tumblr ID"

  Template.hello.events = {
    'click a#refreshBtn' : (event) ->
      newId = $("#tumblrId").val()
      $("#bg").html ""
      window._tumblr.offset = 0 if window._tumblr.hostName.indexOf(newId) < 0
      window._tumblr.hostName = "#{newId}.tumblr.com"
      window._tumblr.photoPosts()
  }

if Meteor.is_server
  Meteor.startup () ->
    return undefined
