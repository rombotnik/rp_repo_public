$(document).on('turbolinks:load', function(){
  var $roleplayWindow = $('#roleplayWindow');

  if ($roleplayWindow.length > 0) {
    var sceneId = $roleplayWindow.data('scene-id');
    var userId = $roleplayWindow.data('user-id');

    var $newPost = $('#new_post');
    var $textarea = $newPost.find('#post_body_trix_input_post');
    var $trix = $newPost.find('trix-editor');
    var trixEditor = $trix[0].editor;
    var $submit = $newPost.find('#post_submit');
    var $body = $('body');
    var $postId = $('#post_id');
    var $cancelBtn = $('.js-rp-cancel');
    var $cancelHelpText = $('.js-rp-cancel-text');
    var $submitHelpText = $('.js-rp-submit-text');
    var $typingState = $('.js-rp-typing-state');
    var title = document.title;

    // blank, entered, typing
    var typingState = 'blank';
    var typingTimeout;

    scrollToBottom();

    App.scenes = App.cable.subscriptions.create({ channel: 'ScenesChannel', id: sceneId }, {
      connected: function() {
        App.scenes.request_info(sceneId, 'typing_state');
      },

      disconnected: function() {
        
      },

      received: function(data) {
        if (data['post']) {
          if (data['user_id'] == userId) {
            resetPostForm();
          }
          if (data['is_deleted']){
            var $post = $roleplayWindow.find('.js-rp-post[data-id="' + data['post_id'] + '"]');
            $post.remove();
          } else if (data['is_new']) {
            $roleplayWindow.append(data['post']);
            scrollToBottom();
            if ($body.hasClass('blurred')) {
              document.title = '! ' + title;
            }
          } else {
            var $post = $roleplayWindow.find('.js-rp-post[data-id="' + data['post_id'] + '"]');
            $post.empty();
            $post.append(data['post']);
          }
        } else if (data['typing_state']) {
          if (data['user_id'] != userId) {
            $typingState.text(data['message']);
          }
        } else if (data['info_type']) {
          if (data['info_type'] == 'typing_state' && data['user_id'] != userId) {
            App.scenes.send_typing_state(sceneId, typingState);
          }
        }
      },

      send_post: function(post, id, post_id) {
        return this.perform('send_post', {
          post: post,
          id: id,
          post_id: post_id
        });
      },

      delete_post: function(id, post_id) {
        return this.perform('delete_post', {
          id: id,
          post_id: post_id
        });
      },

      send_typing_state: function(id, typing_state) {
        return this.perform('send_typing_state', {
          id: id,
          typing_state: typing_state
        });
      },

      request_info: function(id, info_type) {
        return this.perform('request_info', {
          id: id,
          info_type: info_type
        });
      },

    });

    $newPost.submit(function(e){
      if ($.trim($textarea.val()).length > 1) {
        App.scenes.send_post($textarea.val(), sceneId, $postId.val());
      }
      disablePostForm();
      e.preventDefault();
    });

    $cancelBtn.click(function(e){
      resetPostForm();
      e.preventDefault();
    });

    $trix.keydown(function(e){
      // prevent inputs when input is disabled (after submitting)
      if ($trix.hasClass('disabled')) {
        e.preventDefault();
        return;
      }

      // ctrl+enter - submit post
      if (e.which === 13 && (e.ctrlKey || e.metaKey)) {
        e.preventDefault();
        $newPost.submit();
      }
      // esc - cancel editing
      else if (e.which === 27) {
        e.preventDefault();
        $cancelBtn.click();
      }
      // up arrow - edit most recent user post
      else if (e.which === 38) {
        var docLength = trixEditor.getDocument().getLength();

        if (docLength <= 1) {
          e.preventDefault();
          var $post = $roleplayWindow.find('.js-rp-post[data-user-id="' + userId + '"]').last();
          $post.find('.js-rp-post-edit').click();
        }
      }
    });

    $trix.on('trix-change', function(e){
      var docLength = trixEditor.getDocument().getLength();

      // show or hide posting help text
      if (docLength > 1 && !$submitHelpText.hasClass('rp-help-text_visible')) {
        $submitHelpText.addClass('rp-help-text_visible');
      } else if (docLength <= 1 && $submitHelpText.hasClass('rp-help-text_visible')) {
        $submitHelpText.removeClass('rp-help-text_visible');
      }

      // typing state updates
      if (docLength > 1) {
        changeTypingState('typing');
      } else {
        changeTypingState('blank');
      }

    });

    $roleplayWindow.on('click', '.js-rp-post-edit', function(e){
      var $post = $(this).closest('.js-rp-post');
      var $body = $post.find('.js-rp-post-body');
      $body.find('p:empty').remove();

      $trix.addClass('editing');
      $trix.focus();
      $trix.val($body.html().trim());

      // move cursor to end of post
      trixEditor.setSelectedRange(trixEditor.getDocument().getLength() - 1);

      $postId.val($post.data('id'));
      $cancelHelpText.addClass('rp-help-text_visible');

      e.preventDefault();
    });

    $roleplayWindow.on('click', '.js-rp-post-delete', function(e){
      var $post = $(this).closest('.js-rp-post');
      App.scenes.delete_post(sceneId, $post.data('id'));
      e.preventDefault();
    });

    $(window).focus(function() {
      $body.addClass('focused');
      $body.removeClass('blurred');
      document.title = title;
    });

    $(window).blur(function() {
      $body.addClass('blurred');
      $body.removeClass('focused');
    });

    function resetPostForm() {
      $postId.val('');
      $trix.val('');
      $trix.removeClass('editing');
      $trix.removeClass('disabled');
      $trix.focus();
      $cancelHelpText.removeClass('rp-help-text_visible');
      changeTypingState('blank');
    }

    function disablePostForm() {
      $trix.addClass('disabled');
    }

    function scrollToBottom() {
      $roleplayWindow.scrollTop($roleplayWindow.prop('scrollHeight'));
    }

    function changeTypingState(newState) {
      // update typing countdown
      if (typingTimeout != undefined) {
        clearTimeout(typingTimeout);
      }

      // set typing timeout if needed
      if (newState == 'typing') {
        typingTimeout = setTimeout(changeTypingState.bind(null, 'entered'), 3000);
      }

      if (typingState != newState) {
        typingState = newState;
        App.scenes.send_typing_state(sceneId, typingState);
      }
    }

  }

});
