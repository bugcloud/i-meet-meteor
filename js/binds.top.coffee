if Meteor.is_client
  class Tumblr
    constructor: () ->
    apiConsumerKey: "SyMOX3RGVS4OnK2bGWBcXNUfX34lnzQJY5FRB6uxpFqjEHz2SY"
    hostName: "dvdp.tumblr.com"
    offset: 0
    photoPostsCallback: (data, type) ->
     console.log data
    photoPostsBefore: () ->
    photoPosts: () ->
      _that = this
      _that.photoPostsBefore()
      url = "http://api.tumblr.com/v2/blog/#{@hostName}/posts/photo"
      data =
        api_key: @apiConsumerKey
        offset: @offset
      $.ajax url,
        data: data
        dataType: 'jsonp'
        jsonp: 'jsonp'
        success: (data, type) ->
          _that.photoPostsCallback(data, type)
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          console.log errorThrown

  class Post
    constructor: (url, src) ->
      @url = url
      @src = src

  window._tumblr = new Tumblr
  window._tumblr.photoPostsCallback = (data, type) ->
    window._tumblr.offset += data.response.posts.length
    _.each data.response.posts, (d) ->
      _.each d.photos, (photo) ->
        p = new Post(photo.original_size.url, photo.alt_sizes[0].url)
        $("#bg").append "<div class='photo'><a href='#{p.url}' target='_blank'><img src='#{p.src}' /></a></div>"

  $ ->
    window._tumblr.photoPosts()
