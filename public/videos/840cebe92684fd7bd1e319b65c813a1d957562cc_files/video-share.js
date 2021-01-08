$(document).ready(function () {
    var sharevideo = document.getElementById('shareplay_html5_api');
    $('.vjs-control-bar').css('display', 'block');
    if (sharevideo) {
        sharevideo.addEventListener('ended', showHandler, false);
    }

    function showHandler(e) {
        $('.vjs-control-bar').css('display', 'block');
    }

    var is_showing = true;
    var timedelay = 1;

    function delayCheck() {
        if (timedelay === 6) {
            $(".vjs-control-bar").css("display", "none");
            timedelay = 1;
            is_showing = false;
        }
        timedelay = timedelay + 1;
    }

    if (typeof _delay == undefined) clearInterval(_delay);
    _delay = setInterval(delayCheck, 500);

    function showControlBar() {
        $(".vjs-control-bar").css("display", "block");
        timedelay = 1;
        is_showing = true;
        clearInterval(_delay);
        _delay = setInterval(delayCheck, 500);
    }

    function hideControlBar() {
        $(".vjs-control-bar").css("display", "none");
        is_showing = false;
        clearInterval(_delay);
    }


    $(".video div:not(.download):not(.video-share-content-footer)").on({
        'mouseover mousemove': function () {
            showControlBar();
        },
        'mouseout': function () {
            hideControlBar();
        }
    });


    $(".video-share").bind("tap", function () {
        if (is_showing) {
            hideControlBar();
        } else {
            showControlBar();
        }
    });

    $('.share-password').on('keypress', function(e) {
        if (e.which == 13) {
            compare_password_share_video();
        }
    });

    $('.btn-black').on('click', function() {
        compare_password_share_video();
    });

    if (sharevideo) {
        sharevideo.addEventListener('loadeddata', function () {
            $('.video-share video').get(0).volume = bgmHelper.getValueVolume();
        });
    }
    if ($('.video-share video').get(0)) {
        $('.video-share video').get(0).addEventListener('volumechange', function (el) {
            var volume = el.target.volume;
            bgmHelper.setValueVolumm(volume);
        });
    }
});

function countup_download_video_share(video_hash) {
    $.ajax({
        url: '/countup_download_in_shared_video',
        method: "GET",
        'dataType': 'json',
        'data': {'video_data_id': video_hash},
        success: function (response) {
            if (response.error) {
                sentry_capture_message(video_hash, 'response', `Countup Download Video Share Error`);
            }
        },
        error: function(err) {
            sentry_capture_message(err.responseText, 'response', `Countup Download Video Share Error`);
        }
    });
}

function compare_password_share_video() {
    var password = $('.share-password').val();
    if (password.length > 0) {
        var hash = sha1.create();
        hash.update(password);
        var sha1_password = hash.hex();
        $.ajax({
            'url': window.location.href,
            'type':'GET',
            'data':{
                'share_code': sha1_password,
            },
            'dataType':'json',
            'success':function(response){
                if (!response.error) {
                    $('body div').remove();
                    $('body').append(response.html);
                    if($('#shareplay').length > 0){
                        run_videojs_and_handle_error('shareplay');
                    }
                    reload_js("/static/js/video-share.js");
                }
                else {
                    $('.video-share-content .input-message-error').show();
                }
            },
            error: function() {
                $('.video-share-content .input-message-error').show();
            }
        });
    }
}
function reload_js(src) {
    $('script[src^="' + src + '"]').remove();
    $('<script>').attr('src', src + "?hs=" + Math.floor(Math.random() * 10000)).appendTo('head');
}
