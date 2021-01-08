var tab = -1;
var modal_id = '#add-video';
//--------------Check type Image-----------//
var MIMES_IMAGE = ['bmp', 'jpg', 'jpeg', 'png', 'gif', 'jpe', 'webp'];
var MIMES_VIDEO = ['mp4'];
var MIMES_UPLOAD_VIDEO = ['mp4', 'mov', 'avi', '3gp', 'mpg', 'mpeg', 'mkv', 'flv', 'wmv', 'm4v'];
var MIMES_BGM = ['audio/wav', 'audio/mp3', 'audio/mpeg'];
var check_set_video_image = false;
const MAX_UPLOAD = 2, MAX_SIZE_UPLOAD = 200 * 1024 * 1024, MAX_NUMBER_UPLOAD = 20;
const MAX_PDF_UPLOAD_FILE_SIZE = 10 * 1024 * 1024;
const UPLOAD_WARNING = '一度にアップロードできる素材数を超えています。一度にアップロードできる素材は20ファイル（合計200MB）までとなっております。';
const UPLOAD_PDF_WARNING = 'アップロードできるファイルは最大10MBです。10MB以下のファイルをアップロードして下さい。';
let current_time_capture;
var search_data_filter = null;
var search_template_current_page = -1;
var search_template_xhr = null;
var hideFlashTimer;
var MUTE_BACKGROUND_MUSIC_ON = 1;
var MUTE_BACKGROUND_MUSIC_OFF = 0;

/**---------------------- Resolution Modal ----------------------*/
var video_resolutions = {
    "max": {
        "Vertical_GIF": {
            "horizontal": 1080,
            "vertical": 1920
        },
        "Vertical45_GIF": {
            "horizontal": 1080,
            "vertical": 1350
        },
        "Horizontal_GIF": {
            "horizontal": 1920,
            "vertical": 1080
        },
        "Square_GIF": {
            "horizontal": 1080,
            "vertical": 1080
        },
        "Vertical34_GIF": {
            "horizontal": 1440,
            "vertical": 1920
        },
        "Horizontal43_GIF": {
            "horizontal": 1920,
            "vertical": 1440
        }
    },
    "min": {
        "Vertical_GIF": {
            "horizontal": 45,
            "vertical": 80
        },
        "Vertical45_GIF": {
            "horizontal": 64,
            "vertical": 80
        },
        "Horizontal_GIF": {
            "horizontal": 80,
            "vertical": 45
        },
        "Square_GIF": {
            "horizontal": 80,
            "vertical": 80
        },
        "Vertical34_GIF": {
            "horizontal": 60,
            "vertical": 80
        },
        "Horizontal43_GIF": {
            "horizontal": 80,
            "vertical": 60
        }
    },
    "default": {
        "Vertical_GIF": {
            "horizontal": 300,
            "vertical": 534
        },
        "Vertical45_GIF": {
            "horizontal": 300,
            "vertical": 375
        },
        "Horizontal_GIF": {
            "horizontal": 300,
            "vertical": 170
        },
        "Square_GIF": {
            "horizontal": 300,
            "vertical": 300
        },
        "Vertical34_GIF": {
            "horizontal": 225,
            "vertical": 300
        },
        "Horizontal43_GIF": {
            "horizontal": 300,
            "vertical": 225
        }
    },
};
var custom_video_resolutions = {
    "max": {
        "Vertical_Custom": {
            "horizontal": 1080,
            "vertical": 1920
        },
        "Vertical45_Custom": {
            "horizontal": 1080,
            "vertical": 1350
        },
        "Horizontal_Custom": {
            "horizontal": 1920,
            "vertical": 1080
        },
        "Square_Custom": {
            "horizontal": 1080,
            "vertical": 1080
        },
        "Vertical34_Custom": {
            "horizontal": 1440,
            "vertical": 1920
        },
        "Horizontal43_Custom": {
            "horizontal": 1920,
            "vertical": 1440
        }
    },
    "min": {
        "Vertical_Custom": {
            "horizontal": 32,
            "vertical": 57
        },
        "Vertical45_Custom": {
            "horizontal": 32,
            "vertical": 40
        },
        "Horizontal_Custom": {
            "horizontal": 57,
            "vertical": 32
        },
        "Square_Custom": {
            "horizontal": 32,
            "vertical": 32
        },
        "Vertical34_Custom": {
            "horizontal": 32,
            "vertical": 43
        },
        "Horizontal43_Custom": {
            "horizontal": 43,
            "vertical": 32
        }
    },
    "default": {
        "Vertical_Custom": {
            "horizontal": 1080,
            "vertical": 1920
        },
        "Vertical45_Custom": {
            "horizontal": 1080,
            "vertical": 1350
        },
        "Horizontal_Custom": {
            "horizontal": 1920,
            "vertical": 1080
        },
        "Square_Custom": {
            "horizontal": 1080,
            "vertical": 1080
        },
        "Vertical34_Custom": {
            "horizontal": 1440,
            "vertical": 1920
        },
        "Horizontal43_Custom": {
            "horizontal": 1920,
            "vertical": 1440
        }
    },
};

$(document).ready(function() {
    $(document).on('mouseover mouseenter', '.tooltips', function(event) {
        $(this).tooltipster({
            multiple: true,
            contentAsHTML: true,
            delay: 0,
            functionPosition: function(instance, helper, position){
                position.coord.top += 4;
                return position;
            }
        });
        $(this).tooltipster('show');
    });

    $(document).on('mouseover mouseenter', '.tooltips-bottom', function(event) {
        $(this).tooltipster({
            multiple: true,
            position: 'bottom',
            delay: 0,
            functionPosition: function(instance, helper, position){
                position.coord.top -= 4;
                return position;
            }
        });
        $(this).tooltipster('show');
    });

    //------------ Tooltips on menu buttons ------------//
    $('.tooltip-btn-menu').tooltipster({
        position: 'top',
        trigger: 'hover',
        delay: 0,
        functionPosition: function(instance, helper, position){
            position.coord.top += 4;
            return position;
        }
    })
    if ($('.nicescroll').length > 0) {
        $('.nicescroll').niceScroll({
            cursorcolor: '#ddd',
            cursorborder: 'none',
        });
    }

    //------------ View password ------------//

    $(document).on('click', '.view_password', function(event) {
        $(this).toggleClass('showing');
        $(this).find('img').toggle();
        if ($(this).hasClass('showing')) {
            $(this).parent().find('.input').attr('type', 'text');
        } else {
            $(this).parent().find('.input').attr('type', 'password');
        }
    });


    //------------ Input normal ------------//

    $(document).on('blur', '.input', function(event) {
        if (this.value != '') {
            $(this).addClass('has-text');
        } else {
            $(this).removeClass('has-text');
        }
    });

    $(document).on('focus', '.input.error', function(event) {
        $(this).removeClass('error');
        $(this).siblings('.error-message').remove();
    });


    $(".template-bgm .template-bgm__toggle").click( function(){
        bgmHelper.changeMutedTemplate('.template-bgm .template-bgm__toggle');
    });

    //------------ Custom select box------------//

    $('.select-style').each(function(index, el) {
        var numberOfOptions = $(this).children('option').length;
        $(this).attr('hidden', true);
        $(this).wrap('<div class="select"></div>');
        $(this).after(`<a href="javascript:void(0)" class="selected text-ellipsis">${$(this).children('option').eq(0).text().escape()}<i class="fa fa-angle-down" aria-hidden="true"></i></a>`);
        var selected = $(this).next('.selected');
        var list = $('<ul />', { 'class': 'option' }).insertAfter(selected);
        for (var i = 0; i < numberOfOptions; i++) {
            var selected = $(this).children('option').eq(i).attr('selected');
            var _class = '';
            if ($(this).children('option').eq(i).val().length > 0) {
                if (typeof selected !== typeof undefined && selected !== false) {
                    _class = 'active';
                    $(this).parent('.select').find('.selected')
                        .addClass('has-text').html(`${$(this).children('option').eq(i).text().escape()}<i class="fa fa-angle-down" aria-hidden="true"></i></a>`);
                }
                $('<li />', {
                    'text': $(this).children('option').eq(i).text(),
                    'data-value': $(this).children('option').eq(i).val(),
                    'class': _class
                }).appendTo(list);
            }
        }
    });

    $(document).on('click', '.select .selected', function(event) {
        event.stopPropagation();
        $('.select .selected').removeClass('active');
        $(this).toggleClass('active');
    });

    $(document).on('click', '.select .option li', function(event) {
        event.stopPropagation();
        $(this).parents('.select').find('.selected')
            .removeClass('active').addClass('has-text').html(`${$(this).text().escape()}<i class="fa fa-angle-down" aria-hidden="true"></i>`);
        $(this).parent().find('li').removeClass('active');
        $(this).addClass('active');
        $(this).parents('.select').find(`option[value="${$(this).data('value')}"]`).prop('selected', true);
    });

    $(document).on('click', function(event) {
        $('.select .selected').removeClass('active');
    });


    //-------------- Edit profile ------------------//

    $(document).on('click', '#userNav .edit-profile', function(event) {
        check_contract_status();
        $('#edit-profile-modal').modal('show');
    });
    $(document).on('hidden.bs.modal', '#edit-profile-modal', function(event) {
        let username = $('#edit-profile-modal input[name="username"]');
        username.val(username.parent().data('value'));
        let email = $('#edit-profile-modal input[name="email"]');
        email.val(email.parent().data('value'));
        let payload_url = $('#edit-profile-modal input[name="payload_url"]');
        payload_url.val(payload_url.parent().data('value'));
        $('#edit-profile-modal input[name="password"]').val('');
        $('#edit-profile-modal input[name="repeat_password"]').val('');
        $('#edit-profile-modal .change-avatar .name-avatar img').attr('src', $('#edit-profile-modal .change-avatar .name-avatar').data('src'));
        $('.form-group p').remove();
        resetValidate();
    });


    //------------ Click to copy link video------------//

    $(document).on('click', '#share-video-modal #visible-button', function (event) {
        document.querySelector("#visible-input").select();
        if (document.execCommand('copy')) {
            setFlash('コピーしました。');
        }

    });

    $(document).on('click', '#share-video-modal label[for="password-checkbox"]', function (event) {
        let checked = $('#password-checkbox').prop('checked');
        var data_id = getAttrData($('#share-video-modal'), 'id');
        if (checked) {
            $('.share-password-block').hide();
            $('#share-video-modal .input-message-error').hide();
            $.ajax({
                'url':'/delete_password_share_video',
                'type':'POST',
                'data':{
                    'video_data_id': data_id,
                },
                'dataType':'json',
                'success':function(response){
                    if (!response.error) {
                        var input_url = $('#visible-input').val();
                        var share_url = input_url.slice(0,input_url.lastIndexOf('/'));
                        share_url = share_url +'/'+ data_id;
                        $('#visible-input').val(share_url);
                        $('.share-password').val('');
                        $('.check-share-password').val('');
                        setAttrData($(`[data-video-id = ${data_id}]`), 'video-share-password', '');
                        setAttrData($(`[data-video-id = ${data_id}]`), 'video-share-src', share_url);
                    }
                    else {
                        setFlash('削除に失敗しました');
                    }
                },
                error: function() {
                    setFlash('削除に失敗しました');
                }
            });
        }
        else {
            $('.share-password-block').show();
        }
    });
    $(document).on('change', '#share-video-modal #is-download-checkbox', function (event) {
        var data_id = getAttrData($('#share-video-modal'), 'id');
        $.ajax({
            'url':'/show_download_in_share_video',
            'type':'POST',
            'data':{
                'is_download': $('#is-download-checkbox').prop('checked')*1,
                'video_data_id': data_id,
            },
            'dataType':'json',
            'success':function(response){
                if (!response.error) {
                    setAttrData($(`[data-video-id = ${data_id}]`), 'video-download', $('#is-download-checkbox').prop('checked')*1);
                }
                else {
                    setFlash('保存に失敗しました');
                }
            },
            error: function() {
                setFlash('保存に失敗しました');
            }
        });
    });
    $(document).on('click', '#share-video-modal .btn-black', function (event) {
        var pass_share = $('#share-video-modal .share-password').val();
        var pass_check = $('#share-video-modal .check-share-password').val();
        var data_id = getAttrData($('#share-video-modal'), 'id');
        pass_length = pass_share.length;
        if(pass_share != pass_check) {
            if (pass_length >= 4 && pass_length <= 10 && isHalfWidth(pass_share)) {
                let self = $(this);
                self.css('pointer-events', 'none');
                $('#share-video-modal .input-message-error').hide();
                var hash = sha1.create();
                hash.update(pass_share);
                var sha1_password = hash.hex();
                $.ajax({
                    'url':'/save_password_share_video',
                    'type':'POST',
                    'data':{
                        'pass_length': pass_length,
                        'share_password': sha1_password,
                        'video_data_id': data_id,
                    },
                    'dataType':'json',
                    'success':function(response){
                        if (!response.error) {
                            setFlash('保存しました');
                            var input_url = $('#visible-input').val();
                            var share_url = input_url.slice(0,input_url.lastIndexOf('/'));
                            $('#share-video-modal .check-share-password').val(sha1_password);
                            var url_pass = '';
                            if (response.data.indexOf("|") != -1) {
                                var count_pass = response.data.slice(0,response.data.indexOf("|"));
                                for (var i=0; i < count_pass; i++){
                                    url_pass += '*';
                                }
                                share_url = share_url + '/' +response.data.slice(response.data.indexOf("|")+1);
                            }
                            $('#visible-input').val(share_url);
                            setAttrData($(`[data-video-id = ${data_id}]`), 'video-share-src', share_url);
                            setAttrData($(`[data-video-id = ${data_id}]`), 'video-share-password', response.data);
                        }
                        else {
                            setFlash('保存に失敗しました');
                        }
                        self.removeAttr('style');

                    },
                    error: function() {
                        self.removeAttr('style');
                        setFlash('保存に失敗しました');
                    }
                });
            }
            else {
                $('#share-video-modal .input-message-error').show();
            }
        }
    })

    $('#sidebar .project .list-project.nicescroll').on('wheel', function(e){
        e.preventDefault();
    });
});

function isHalfWidth(str){
    if(str.match(/^[A-Za-z0-9]*$/)) {
      return true;
    } else {
      return false;
    }
}

/******************hover animate**********************/
$(function() {
    $('.hoverJS').hover(function() {
        if (!$(this).hasClass('search_url_button'))
        $(this).stop().fadeTo(100, 0.8);
    }, function() {
        $(this).stop().fadeTo(100, 1);
    });
});

$(function() {
    $(document).on('mouseover', '.hoverJS2', function(event) {
            var src1 = $(this).find("img").not(".no-change").attr('src');
            if (src1) {
                src1 = src1.replace(".png", "");
                src1 = src1 + "-hover.png";
                $(this).find("img").not(".no-change").attr('src', src1);
            }
        })
        .on('mouseout', '.hoverJS2', function(event) {
            var src1 = $(this).find("img").not(".no-change").attr('src');
            if (src1) {
                src1 = src1.replace("-hover", "");
                $(this).find("img").not(".no-change").attr('src', src1);
            }
        });
});

$(function() {
    $(document).on('mouseover', '.hoverJS2SVG', function(event) {
            var src1 = $(this).find("img").not(".no-change").attr('src');
            if (src1) {
                src1 = src1.replace(".svg", "");
                src1 = src1 + "_a.svg";
                $(this).find("img").not(".no-change").attr('src', src1);
            }
        })
        .on('mouseout', '.hoverJS2SVG', function(event) {
            var src1 = $(this).find("img").not(".no-change").attr('src');
            if (src1) {
                src1 = src1.replace("_a", "");
                $(this).find("img").not(".no-change").attr('src', src1);
            }
        });
});

/******************custom flash message**********************/
$(function() {
    $(document).on('click', '.alert.alert-black .close', function(event) {
        var self = this;
        $(self).parent().removeAttr('style');
        setTimeout(function() {
            $(self).parent().remove();
        }, 300);
    });

    $(document).on('show.bs.modal', '.modal', function(event) {
        $('.alert').remove();
        setTimeout(calculateTabContent, 200);
    });
});


String.prototype.escape = function() {
    let tagsToReplace = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;'
    };
    return this.replace(/[&<>]/g, function(tag) {
        return tagsToReplace[tag] || tag;
    });
};

function setFlash(message, revert, revert_func) {
    $('.alert').remove();
    if(message != null) {
        var flash = $('<div />', { 'class': 'alert alert-black' });
        flash.append(`<a href="javascript:void(0)" class="close"><img src="/static/img/common/close.png" width="12" alt="Close"></a>${message.escape()}`);
        if(revert) flash.children('.close').after(`<a href="javascript:${revert_func}" class="revert">元に戻す</a>`);
        $('body').prepend(flash);
        if (hideFlashTimer != undefined)
            clearTimeout(hideFlashTimer);
        hideFlashTimer = setTimeout(function() { flash.css({ opacity: 1, transform: 'translateX(-50%) translateY(0)' }); }, 100);
        hideFlashTimer = setTimeout(function() {
            if ($('.alert.alert-black .close').length > 0) {
                $('.alert.alert-black .close').click();
            }
        }, 3000);
    } else return false;
}

/******************check number input**********************/
function isNumeric(num){
    return !isNaN(num);
}

function isASCII(str) {
    return /^[\x00-\x7F]*$/.test(str);
}

/******************check link login yahoo**********************/
$(function() {
    var YCOOKIE = 'YAHOO';
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function delete_cookie( cname ) {
        setCookie(cname, "", 0);
    }

    // check url login
    if(window.location.href.indexOf("/accounts/login/") > -1) {
       // check url has ys
        if (checkYahooUrl()) {
            setCookie(YCOOKIE,'yahoo',1);
        }
        else {
            delete_cookie(YCOOKIE);
        }

    }
});

function checkYahooUrl() {
    return window.location.search.indexOf("f=yj") > -1;
}

/******************Show Image or Video**********************/
function fixWidthHeightImage(el, width, height) {
    var widthEl = $(el).width();
    var heightEl = $(el).height();
    if (width != undefined && height != undefined) {
        widthEl = width;
        heightEl = height;
    }
    $(el).css('width', 'auto');
    $(el).css('height', 'auto');
    // check size on library, parent bound has size 140x105(not equal)
    if ($(el).hasClass('image-for-drag')) {
        if (parseFloat(widthEl) / parseFloat(heightEl) >= 140/105) {
            $(el).css('width', '100%');
        }
        else {
            $(el).css('height', '100%');
        }
    }
    else {
        var src = $(el).attr('src');
        var preview_src = $(el).parent().find('.img-template img').attr('src');
        if (parseFloat(widthEl) >= parseFloat(heightEl)) {
            $(el).css('width', '100%');
            if ($(el).hasClass('image-show-right') && src == preview_src) {
                $(el).parent().find('.img-template img').css('width', '100%').css('height', 'auto').css('display','inline-block');
            }
        }
        else {
            $(el).css('height', '100%');
            if ($(el).hasClass('image-show-right') && src == preview_src) {
                $(el).parent().find('.img-template img').css('height', '100%').css('width', 'auto').css('display','inline-block');
            }
        }
    }
}

function createLiElementLibrary(media_url, stock_url = '') {
    if (isImageFname(media_url)) {
        var li = '<li class="image">';
    }
    else {
        var li = `<li class="image video" data-before="0">`;
    }
    if(stock_url != ''){
        li += `<input type="hidden" class="imageStockPath" value="${stock_url}">`;
    }
    li += `<input type="hidden" class="imagePath" value="${media_url}">`;
    li += '<p class="thumb">';
    li += '<span style="z-index: 2;">';
    if (isImageFname(media_url)) {
        li += `<img crossorigin="anonymous" src="/static/${media_url}" alt="" class="image-for-drag" data-width="0" data-height="0">`;
    }
    else {
        li += `<video crossorigin="anonymous" oncontextmenu="return false;" draggable="true" src="/static/${media_url}" class="video-for-drag video-show" preload="metadata"> </video>`;
    }
    li += '</span></p>';
    li += '<div class="control_bar">';
    li += '<a href="javascript:void(0)" class="check"></a>';
    li += '<a href="javascript:void(0)" class="delete delete-image tooltips tooltipstered"><img src="/static/img/common/icon_material_delete.svg" alt="Delete"></a>';
    li += '</div>';
    li += '</li>';
    return li;
}

function isImageInStockVideo(src) {
    return $(`#stock-video img[src="${src}"]`).length > 0;
}

function get_material_extension(material_path) {
    let extension = null;
    if (material_path) {
        let tmp = material_path.split('?')[0];
        extension = tmp.substr(tmp.lastIndexOf('.') + 1).toLowerCase();
    }
    return extension;
}

function get_sg_path(path) {
    let ret_path = path;
    if (path.indexOf('tmp/') !== -1) {
        ret_path = '/static/' + path.substr(path.indexOf('tmp/')).split('?')[0];
    }
    return ret_path;
}

function isImageFname(fname) {
    let extension = get_material_extension(fname);
    return MIMES_IMAGE.indexOf(extension) !== -1 || $(`#stock-photo img[src="${fname}"]`).length > 0;
}

function isVideoFname(fname) {
    let extension = get_material_extension(fname);
    return MIMES_VIDEO.indexOf(extension) !== -1 || $(`#stock-video video[src="${fname}"]`).length > 0;
}

function convertSecondToTime(seconds) {
    var date = new Date(null);
    date.setSeconds(Math.floor(seconds)); // specify value for SECONDS here
    if (isNaN(date)) return '00:00:00';
    var result = date.toISOString().substr(11, 8);
    return result;
}

function addDurationTimeToVideo(el) {
    $(el).on('loadedmetadata', function () {
        var liVideo = $(this).parents('li.image');
        if (liVideo.length > 0) {
            if (!liVideo.hasClass('video')) {
                liVideo.addClass('video');
            }
            var time = convertSecondToTime(this.duration);
            setAttrData(liVideo, 'before', time);
        }
    });
}

function isEmpty(obj) {
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop))
            return false;
    }

    return true;
}
/******************stop all videos after play 1 video**********************/
$(function() {
    let videoItems = document.querySelectorAll('video');
    for (i = 0; i < videoItems.length; i++) {
        videoItems[i].addEventListener("play", stopAllVideos);
        videoItems[i].addEventListener("ended", showControlBar);
        videoItems[i].addEventListener("pause", showControlBar);
    }
})
function changeVolume(el) {
    let video = el.target;
    var volume = video.volume;
    bgmHelper.setValueVolumm(volume)
    var list_video = $('.list-template .video-item video');
    if (list_video.length == 0) {
        list_video = $('.list-video .video-item video');
    }
    for (var i=0; i< list_video.length; i++) {
        if (list_video[i] != video) {
            list_video[i].volume = volume;
        }
    }
}
function showControlBar(el) {
    let controlBar = $(el.target).parent().find('.vjs-control-bar');
    if (controlBar.length > 0) {
        controlBar.attr('style', 'display: block');
    }
    if ($(el.target).closest('.list-video').length > 0) {
        $(el.target).parents('.video-item').find('.label-video').show();
    }
}
function stopAllVideos(el = null) {
    let videoItems = document.querySelectorAll('video');
    let video = null;
    var volume = bgmHelper.getValueVolume();
    if (el) {
        video = el.target;
        if ($(video).parents('.list-template').length > 0 || $(video).parents('.list-video').length > 0) {
            video.volume = volume;
        }
    }
    if ($(video).closest('#preview-generated-video-modal').length > 0){
        for (i = 0; i < videoItems.length; i++) {
            if (videoItems[i] != video) {
                if ($(videoItems[i]).closest('#download-thumbnail-video-modal').length === 0) {
                    videoItems[i].pause();
                }
            }
        }
    }
    else if ($(video).closest('#download-thumbnail-video-modal').length > 0) {
        for (i = 0; i < videoItems.length; i++) {
            if (videoItems[i] != video) {
                if ($(videoItems[i]).closest('#preview-generated-video-modal').length === 0) {
                    videoItems[i].pause();
                }
            }
        }
    }
    else {
        for (i = 0; i < videoItems.length; i++) {
            if (videoItems[i] != video || !el) {
                videoItems[i].pause();
            }
        }
    }
}

/******************Load group video**********************/
function loadGroupVideojs(videoItems, modal_id, after_video_loading) {
    loadVideojs(videoItems, 0, modal_id, after_video_loading);
    setTimeout(loadVideojs(videoItems, 1, modal_id, after_video_loading), 50);
    setTimeout(loadVideojs(videoItems, 2, modal_id, after_video_loading), 100);
    setTimeout(loadVideojs(videoItems, 3, modal_id, after_video_loading), 150);
    setTimeout(loadVideojs(videoItems, 4, modal_id, after_video_loading), 200);
}

/******************Load video**********************/
function loadVideojs(videoItems, index, modal_id, after_video_loading){
    var video = videoItems[index];
    if (video) {
        video.addEventListener("play", stopAllVideos);
        video.addEventListener("volumechange", changeVolume);
        video.addEventListener("ended", showControlBar);
        video.addEventListener("pause", showControlBar);
    }
    if (video !== undefined) {
        var poster = video.getAttribute('xx-poster');
        if (poster === null) {
            if (video.getAttribute('preload') === 'none') {
                video.setAttribute('preload', 'metadata');
                addDurationTimeToVideo(video);
            }
        }
        else {
            var img = new Image();
            img.crossOrigin = 'anonymous';
            img.src = poster;
            img.onload = function () {
                setTimeout(function(){video.setAttribute('poster', poster)}, 200);
                if ($('.modal-template-list').hasClass('in') || $(video).closest('.list-video').length > 0) {
                    let player = run_videojs_and_handle_error(video, bgmHelper.getVideoOption());
                    player.getChild('controlBar').addChild('myButton', {});
                }
                else {
                    run_videojs_and_handle_error(video, bgmHelper.getVideoOption());
                }
                if (modal_id == '#change-template-modal') {
                    after_video_loading(modal_id, video);
                }
            }
        }
    }
    index += 5;
    if (index < videoItems.length) {
        setTimeout(loadVideojs(videoItems, index, modal_id, after_video_loading), 400);
    }
}

/******************Load group video material**********************/
function loadGroupVideoMaterialjs(videoItems, modal_id, after_video_loading){
    loadVideoMaterialjs(videoItems, 0, modal_id, after_video_loading);
    setTimeout(loadVideoMaterialjs(videoItems, 1, modal_id, after_video_loading), 50);
    setTimeout(loadVideoMaterialjs(videoItems, 2, modal_id, after_video_loading), 100);
    setTimeout(loadVideoMaterialjs(videoItems, 3, modal_id, after_video_loading), 150);
    setTimeout(loadVideoMaterialjs(videoItems, 4, modal_id, after_video_loading), 200);
}
/******************Load video material**********************/
function loadVideoMaterialjs(videoItems, index, modal_id, after_video_loading){
    var video = videoItems[index];
    if (video !== undefined) {
        video.setAttribute('preload', 'metadata');
        video.onloadedmetadata = function() {
            index += 5;
            if (index < videoItems.length) {
                setTimeout(loadVideoMaterialjs(videoItems, index, modal_id, after_video_loading), 400);
            }
            var time = convertSecondToTime(this.duration);
            setAttrData(this.closest('li'), 'before', time);
            this.closest('li').classList.add('video');
        };
        video.onerror = function() {
            index += 5;
            if (index < videoItems.length) {
                setTimeout(loadVideoMaterialjs(videoItems, index, modal_id, after_video_loading), 400);
            }
        };
    }
}

/******************Load group image**********************/
function loadGroupImagejs(imageItems, modal_id, after_video_loading){
    loadImagejs(imageItems, 0, modal_id, after_video_loading);
    setTimeout(loadImagejs(imageItems, 1, modal_id, after_video_loading), 50);
    setTimeout(loadImagejs(imageItems, 2, modal_id, after_video_loading), 100);
    setTimeout(loadImagejs(imageItems, 3, modal_id, after_video_loading), 150);
    setTimeout(loadImagejs(imageItems, 4, modal_id, after_video_loading), 200);
}
/******************Load image**********************/
function loadImagejs(imageItems, index, modal_id, after_video_loading){
    var image = imageItems[index];
    if (image !== undefined && image.getAttribute("src") == null) {
        let data_src = getAttrData($(image), 'src');
        if (data_src !== null && !data_src.includes('.mp4')) {
            let img = new Image();
            img.crossOrigin = 'anonymous';
            img.src = data_src;
            img.onload = function () {
                image.src = data_src;
            }
        }
    }
    index += 5;
    if (index < imageItems.length) {
        setTimeout(loadImagejs(imageItems, index, modal_id, after_video_loading), 400);
    }
}

function template_name_tooltip() {
    $('.list-template .video-item .header .display-name').each(function(index, el) {
        if (el.scrollWidth > el.clientWidth) {
            $(el).addClass('tooltips');
            $(el).prop('title', $(el).text());
        }
    });
}

/******************Get template pagination**********************/
function template_paging_index(modal_id, tab, page, after_video_loading, template_id=null, template_set=null){
    // remove warning if load new template page
    let {dataFilter, is_valid} = getParamSearch();
    $('.template-bgm__switch .template-bgm__toggle').prop('disabled', true);
    page = isNumeric(page)?page:1;
    var modal_id_content;
    if (tab == 0) {
        modal_id_content = modal_id + ' #template-basic';
    }
    else if (tab == 1) {
        modal_id_content = modal_id + ' #template-business';
        $(modal_id + ' #template-business').removeClass('template-empty').css('padding-bottom', '0');
    }
    else if (tab == 2) {
        modal_id_content = modal_id + ' #template-favorite';
    }
    else if (tab == 3) {
        modal_id_content = modal_id + ' #template-recently';
    }
    modal_id_content += ' .modal-main-list .tab-pane';
    setAttrData($(modal_id_content), 'page', page);
    let modal_main = $(modal_id_content).closest('.modal-main');
    if(search_template_xhr && search_template_xhr.readyState !== 4){
        search_template_xhr.abort();
    }
    stopAllVideos();
    let current_template_id = null;
    if (modal_id === '#change-template-modal') {
        current_template_id = getAttrData($(modal_id), 'template-id');
    }
    search_template_xhr = $.ajax({
        url: '/get_paged_template_list',
        type: 'GET',
        cache: false,
        headers: {"X-CSRFToken": getCookie("csrftoken")},
        beforeSend: function () {
            modal_main.children().addClass('hidden_class');
            modal_main.append(getLoadingAnimationFormatListHtml());
        },
        data: {
            'page': page,
            'tab' : tab,
            'template_id': template_id,
            'template_set': template_set,
            'video_template': current_template_id,
            'filter': JSON.stringify(dataFilter)
        },
        success: function(response){
            modal_main.find('div.loading-animation-container').remove();
            modal_main.children().removeClass('hidden_class');
            calculateTabContent();
            if(response.length > 0){
                if (template_id) {
                    $('.template-list-folder').remove();
                    $('.template-set-name').remove();
                    $('.template-list-main').hide();
                }
                else {
                    $('.template-list-folder').hide();
                    $('.template-list-main').show();
                }
                $('.list-template .tab-content').css('overflow-y', 'scroll');

                var videoItems = document.querySelectorAll(modal_id_content + ' video');
                if (!template_id) {
                    for (i = 0; i < videoItems.length; i++) {
                        if ($(videoItems[i]).closest('.modal-main-full').length == 0) {
                            run_videojs_and_handle_error(videoItems[i]).dispose();
                        }
                    }
                    $(modal_id_content).empty();
                }
                $(modal_id_content).append(response);
                if (modal_id === '#change-template-modal') {
                    $('#change-template-modal .modal-bottom-general .btn-red').prop('disabled', true);
                }
                var videoItems = document.querySelectorAll(modal_id + ' video');
                if(after_video_loading != null){
                    after_video_loading(modal_id);
                }
                loadGroupVideojs(videoItems, modal_id, after_video_loading);
                if (tab == 0) {
                    $('#template-basic .modal-sidebar-list').html($('.template_list_number').html());
                    $('#template-basic .modal-main-sort.modal-search').hide();
                }
            }
            // empty data return and click tab favourite, show empty
            else if (tab == 2) {
                $('.list-template .tab-content').css('overflow-y', 'hidden');
                $(modal_id_content).empty();
                $(modal_id_content).append('<div class="empty">お気に入りに登録がございません</div>');
                var height = $(modal_id_content).closest('.modal-main-list').height();
                $(modal_id_content + ' .empty').css('margin-top', height / 3 + 'px');
            }
            else if (tab == 1){
                $(modal_id_content).empty();
                $(modal_id_content).addClass('template-empty').append('<img class="empty-image" src="/static/img/common/banner.png">');
                if (modal_id == '#add-video') {
                    let parent = $(modal_id_content).closest('.modal-main-list');
                    $(modal_id_content).parent().css({'height': '100%'});
                    $(modal_id_content).css({'height': '100%'});
                    if (parent.width()/parent.height() > 1862/1054) {
                        $(modal_id_content).find('.empty-image').css({'width': parent.height() / 1054 * 1862 + 'px', 'height': parent.height() + 'px'});
                    }
                    else {
                        $(modal_id_content).find('.empty-image').css({'width': parent.width() + 'px', 'height': parent.width() / 1862 * 1054 + 'px'});
                    }
                }
                else {
                    $(modal_id_content).css({'padding-bottom': '30px', 'padding-left': '10px'});
                    var height = $('.modal-body > .list-template .tab-content').height() - $('.modal-body .list-template-nav').height();
                    $(modal_id + ' #template-business').css('height', height);
                    var width = $(modal_id + ' #template-business').width();
                    if (width/height > 1862/1054) {
                        $('#template-business .empty-image').css({'width': 'auto', 'height':'100%'});
                    }
                    else {
                        $('#template-business .empty-image').css({'height': 'auto', 'width':'100%'});
                    }
                }
            }
            setTimeout(function(){ bgmHelper.changeMutedTemplate('.template-bgm .template-bgm__toggle'); }, 2000);
            $('.template-bgm__switch .template-bgm__toggle').prop('disabled', false);
            template_name_tooltip();
        },
    });
}

/******************Show/hide template folder in list template popup**********************/
$(function(){

    //フォルダ 展開処理
    $('.video-item.video-folder').on('click', function(){
        var folderClass = $(this).attr('class').match(/video-folder-[0-9]+/).toString();
        var folderNum = folderClass.replace("video-folder-","");
        $('.tab-pane').removeClass('active');
        $('#template-basic').addClass('active');
        $('.template-list-main').hide();
        $('.template-list-folder-' + folderNum).show();
        return false;
    });
    //フォルダ ホームへ戻る
    $(document).on('click', '.template-back-home', function(){
        $('#template-basic .modal-main-sort.modal-search').show();
        $('#template-basic .modal-main-title').text('');
        $('.template-list-main').show();
        $('.template-list-folder').hide();
        $('.template-list-folder .video-item ').removeClass('checked');
        $('#change-template-modal input[name=template_id]').val('');
        $('.template-list-folder video').each(function() {
            if (!this.paused) {
                this.pause();
            }
        });
        $('#change-template-modal .modal-bottom-general .btn-red').prop('disabled', true);
        return false;
    });

    $(document).on('mouseenter', '.video-item .vjs-volume-panel', function(){
        var video = $(this).parents('.video').find('video');
        volume = bgmHelper.getValueVolume();
        video[0].volume = volume;
        $(this).parents('.video').find('.vjs-mute-control').attr('title','');
    });
});

$(function() {
    /******************Process list template popup**********************/
    $(document).on('click', '#topbar .btn-change-template, #topbar .add-video', function (event) {
        check_contract_status();
        if (event.currentTarget.classList.contains('add-video')) {
            modal_id = '#add-video';
        } else {
            modal_id = '#change-template-modal';
        }
        var mute_background_music = bgmHelper.getStatusMute();
        var INITIALIZE_TAB = -1;
        if (tab == INITIALIZE_TAB) {
            $.ajax({
                url: '/has_business_template',
                type: 'GET',
                success: function (response) {
                    tab = response.result ? 1 : 0;
                    $('.modal-head ul li').eq(tab).click();
                    if (tab == 1) {
                        // change the default tab to business one
                        has_basic = response.has_basic ? 1 : 0;
                        if (has_basic == 0) {
                            $('.select-template li:first').css('display', 'none');
                            $('.select-template li:eq(1)').css('margin-left', 0);
                        }
                        else {
                            $('.select-template li:first').css('display', 'block');
                        }
                    }
                    if ($(modal_id + ' #template-basic .template-list-main').html().trim() == '' && tab == 1)
                        template_paging_index(modal_id, tab, 1, after_video_loading);
                    else {
                        search_template_by_filter(1, after_video_loading);
                    }

                }
            });
            $.ajax({
                url: '/search_ae_template_params',
                type: 'GET',
                success: function (response) {
                    const aspectratio = response.aspectratio;
                    const scale = response.scale;
                    const distribution_destination = response.distribution_destination;
                    add_params(aspectratio, 'aspect', 5);
                    add_params(scale, 'scale', 6);
                    add_params(distribution_destination, 'distribution_destination', 3);
                    $('.modal-refine-list').trigger('filter_list_changed');
                }
            });
        }
        else {
            const tab_id = '#' + $('.list-template-nav ul li a.active').attr('href').split('#')[1];
            tab = parseInt($(tab_id).attr('tab-content'));
            page = 1;
            if (tab_id === '#template-basic') {
                select_search_template_type(tab, page, after_video_loading)
            }
            else {
                template_paging_index(modal_id, tab, page, after_video_loading);
            }
        }

        if (mute_background_music == MUTE_BACKGROUND_MUSIC_ON) {
            $('.template-bgm input.template-bgm__toggle').prop('checked', false);
        } else {
            $('.template-bgm input.template-bgm__toggle').prop('checked', true);
        }
        bgmHelper.changeMutedTemplate('.template-bgm .template-bgm__toggle');
        if (modal_id === '#add-video'){
            const sample_video_name = create_name_from_date(new Date());
            $('input.title-material').val(sample_video_name);

            let projectId = getAttrData($('#content'), 'project-url');
            let node = $("#new-movie-dlg-jqtree-shared").tree('getNodeById', projectId);
            if (!node){
                node = $("#new-movie-dlg-jqtree-owned").tree('getNodeById', projectId);
            }
            if (!node){
                node = $("#new-movie-dlg-jqtree-owned").tree('getTree').children[0];
            }
            if (!node){
                node = $("#new-movie-dlg-jqtree-shared").tree('getTree').children[0];
            }
            if (node){
                projectId = node["hash"];
                $("#new-movie-dlg-jqtree-shared").tree('selectNode', node);
                $("#add-video input#project_id").val(projectId);
                $('#add-video .select > .selected').text(node["name"]).addClass('has-text').removeClass('active');
                setAttrData($('#add-video .select > .selected'), 'hash', projectId);
            }
        }
        createListFilter();
        $(modal_id).modal('show');
        if (modal_id !== '#change-template-modal') {
            $(modal_id).find('.btn-red')[0].disabled = false;
        } else {
            $(modal_id).find('.btn-red')[0].disabled = true;
        }
    });

    function create_name_from_date(datetime){
        return convert_date_time_to_string(datetime, 'YYYYMMDD_HHmm');
    }

    function add_params(value, params, index) {
        for (var i=0; i< value.length; i++){
            var html_composition = html_params_template(value[i], params, index);
            $(`.modal-refine-list .${params} ul`).append(html_composition);
        }
    }

    function html_params_template(value, params, index){
        var html = '<li>';
            html += `<input type="checkbox" name="checkbox_${value.id}" id="cat${index}_${value.id}" data-cat="${params}" data-id="${value.id}">`;
            if(params == 'aspect') {
                html += `<label for="cat${index}_${value.id}">${ value.aspect_ratio }</label>`;
            } else {
                html += `<label for="cat${index}_${value.id}">${ value.name }</label>`;
            }
            html += '</li>';
        return html;
    }

    if ($(modal_id).length == 0) {
        modal_id = "#change-template-modal";
    }

    function create_search_template_type(tab, page, after_video_loading, el) {
        if (data_template_id = checkPaginatorForTemplateSet(el)) {
            select_search_template_type(tab, page, after_video_loading, false, data_template_id);
        }
        else {
            select_search_template_type(tab, page, after_video_loading);
        }
    }

    function checkPaginatorForTemplateSet(el) {
        if ($(el).closest('.template-list-folder').length > 0) {
            let data_template_id = $(el).closest('.template-list-folder').find('.video-item:first').data('template-id');
            return data_template_id;
        }
        else {
            return false;
        }
    }

    //------------ Check search template or paging template at list template popup ------------//
    function select_search_template_type(tab, page, after_video_loading, forced = false, data_template_id = null) {
        if (tab == 0 && !data_template_id) {
            search_template_by_filter(page, after_video_loading, forced);
        }
        else {
            template_paging_index(modal_id, tab, page, after_video_loading, data_template_id);
        }
    }
    //------------ Click page number ------------//
    $(document).on('click', '#add-video .list-template-pagination li a, #change-template-modal .list-template-pagination li a', function (event) {
        tab = parseInt($(this).closest('.tab-pane').attr('tab-content'));
        var page = parseInt($(this).text());
        create_search_template_type(tab, page, after_video_loading, this);
    })

    //------------ Click previous page at list template or media stock popup------------//
    $(document).on('click', '#add-video .list-template-pagination-prev, #change-template-modal .list-template-pagination-prev', function (event) {
        tab = parseInt($(this).closest('.tab-pane').attr('tab-content'));
        var page = parseInt($(this).closest('.list-template-pagination').find('a[class="active"]').text());
        page--;
        create_search_template_type(tab, page, after_video_loading, this);
    })

    //------------ Click next page at list template or media stock popup------------//
    $(document).on('click', '#add-video .list-template-pagination-next, #change-template-modal .list-template-pagination-next', function (event) {
        tab = parseInt($(this).closest('.tab-pane').attr('tab-content'));
        var page = parseInt($(this).closest('.list-template-pagination').find('a[class="active"]').text());
        page++;
        create_search_template_type(tab, page, after_video_loading, this);
    })

    //------------ Click tab pane at list template popup ------------//
    $(document).on('click', '.list-template-nav ul li a', function () {
        $('#change-template-modal input[name=template_id]').val('');
        $('.template-list-main .video-item').removeClass('checked');
        var tab_id = '#' + this.href.split('#')[1];
        tab = parseInt($(tab_id).attr('tab-content'));
        page = getAttrData($(modal_id + ' ' + tab_id), 'page');
        $('.template-list-folder').hide();
        $('.template-set-name').hide();
        if (tab_id == '#template-basic') {
            $('.modal-bottom-create').show();
            $('.list-template .drop-down').show();
            $('.list-template .modal-search').show();
            if ($(`${tab_id} .template-list-main div`).length == 0) {
                select_search_template_type(tab, page, after_video_loading, true);
            }
        }
        else {
            $('.modal-bottom-create').hide();
            $('.list-template .drop-down').hide();
            $('.list-template .modal-search').hide();
            if ($(`${tab_id} .template-list-main div`).length == 0 || tab_id == '#template-favorite') {
                template_paging_index(modal_id, tab, page, after_video_loading);
            }
        }
        hideLabelInfo();
        let current_template = $('.template-list-main .video-item[data-belong-set="1"]');
        if (current_template.length > 0) {
            current_template.addClass('checked');
        }
    })

    //------------ Click page number ------------//
    $(document).on('click', '.template-back-home', function(){

        var tab_pane = $(this).closest('.tab-pane');// get tab pane parent
        var tab_content = tab_pane.parent();
        tab_pane.find('.template-list-main').show();// show list parent
        var tab_pane_id = tab_pane.attr('id');// get id tab panen
        // dispose video
        var videoItems = document.querySelectorAll('#' + tab_pane_id + ' .template-list-folder video');
        for (i = 0; i < videoItems.length; i++) {
            run_videojs_and_handle_error(videoItems[i]).dispose();
        }
        // remove template set and template set name
        tab_pane.find('.template-list-folder').remove();
        tab_pane.find('.template-set-name').remove();

        // find video item folder at parent list
        var data_template_set_id = getAttrData($(this), 'template-set');
        var video_item = $('.template-list-main .video-item[data-template-id^="' + data_template_set_id + '"]');
        if (video_item.length > 0) {
            $('.tab-content').scrollTop($('.tab-content').scrollTop() + $('.template-list-main .video-item[data-template-id^="' + data_template_set_id + '"]').offset().top - 300)
        }
        let current_template = $('.template-list-main .video-item[data-belong-set="1"]');
        if (current_template.length > 0) {
            current_template.addClass('checked');
        }
        hideLabelInfo();

        return false;
    });
    window.addEventListener('resize', function(event){
        calculateTabContent();
    })

    //------------ set/unset favorite ------------//
    $(document).on('click', '.favorite.favorite-image', function (event) {
        if ($('.material #materials').hasClass('active')) {
            var is_owner = $('.folder_container li.jqtree-selected .setting').find('input[name="is_owner"]').val();
            if (is_owner != undefined && is_owner.toLowerCase() == "false"){
                $('#favorite-message-shared-stock').modal('show');
                return;
            }
        }
        var el = $(this).parents('li.image');
        var target = $(el).find('input:first');
        var targetPath = target.attr('value');
        var folder_id = getAttrData($('.folder_path'), 'id');
        var is_favorite = $(this).hasClass('active');
        var _this = $(this);
        // is favourite
        $.ajax({
            'url': '/update_favourite_material',
            'type': 'POST',
            'data': {
                'path': targetPath,
            },
            'dataType': 'json',
            'success': function(response){
                if (folder_id == 'favorite')
                    $(el).appendTo('ul.list-media:eq(0)').slideDown('slow');
                else {
                    if (is_favorite){
                        $(_this).removeClass('active');
                        $(_this).tooltipster('content', 'お気に入り登録');
                    }
                    else {
                        $(_this).addClass('active');
                        $(_this).tooltipster('content', 'お気に入り解除');
                    }
                }
            }
        });
    })

    //------------ Stop all playing video when clicking close button on creating video ------------//

    function reset_videos_on_change() {
        let videos = $(`${modal_id} .video video`);
        Array.prototype.forEach.call(videos, function(video) {
            if (!!(video.currentTime > 0 && !video.paused && !video.ended && video.readyState > 2)) {
                video.pause();
            }
        });
        let vjs_buttons = $(`${modal_id} .video .vjs-control-bar .vjs-play-control.vjs-control.vjs-button`);
        Array.prototype.forEach.call(vjs_buttons, button => button.className = "vjs-play-control vjs-control vjs-button");
        let vjs_bar = $(`${modal_id} .video .vjs-control-bar`);
        Array.prototype.forEach.call(vjs_bar, bar => bar.style = "display: block !important");
    }

    $(document).on('click', '#change_template .close img, #change_template .nav-item, #create_video_data button img, #create_video_data .nav-item', function (event) {
        reset_videos_on_change();
    });

    //------------ catch event when click video in list template popup ------------//
    $(document).on('click', '.list-template .video-item', function (event) {
        // favourite template
        if ($(event.target).hasClass('favorite-template') && getAttrData($(event.target).closest('.video-item'), 'template-id')) {
            var video_item = $(event.target).closest('.video-item');
            var template_id = getAttrData(video_item, 'template-id');
            var is_set = video_item.hasClass('is-set')?1:0;
            // is favourite
            $.ajax({
                'url': '/update_favourite_template',
                'type': 'POST',
                'data': {
                    'template_id': template_id,
                    'is_set': is_set,
                },
                'dataType': 'json',
                'success': function(response){
                    //update for basic tab and business tab
                    var template_basic_item = template_business_item = template_recently_item = null;
                    var modal_body_tab = $(video_item).closest('.modal-body-tab');
                    if (modal_body_tab.attr('id') !== 'template-basic' && $(`#template-basic .video-item[data-template-id="${template_id}"]`).length > 0) {
                        template_basic_item = $(`#template-basic .video-item[data-template-id="${template_id}"]`);
                    }
                    if (modal_body_tab.attr('id') !== 'template-business' && $(`#template-business .video-item[data-template-id="${template_id}"]`).length > 0) {
                        template_business_item = $(`#template-business .video-item[data-template-id="${template_id}"]`);
                    }
                    if (modal_body_tab.attr('id') !== 'template-recently' && $(`#template-recently .video-item[data-template-id="${template_id}"]`).length > 0) {
                        template_recently_item = $(`#template-recently .video-item[data-template-id="${template_id}"]`);
                    }
                    if (response.result) {
                        if ($(event.target).hasClass('active')) {
                            $(event.target).removeClass('active');
                            if ($(video_item).closest('#template-favorite').length) {
                                $(video_item).closest('.col-md-4').remove();
                            }
                            if (template_basic_item)
                                template_basic_item.find('a.favorite-template').removeClass('active');
                            if(template_business_item)
                                template_business_item.find('a.favorite-template').removeClass('active');
                            if(template_recently_item)
                                template_recently_item.find('a.favorite-template').removeClass('active');
                        }
                        else {
                            $(event.target).addClass('active');
                            if(template_basic_item)
                                template_basic_item.find('a.favorite-template').addClass('active');
                            if(template_business_item)
                                template_business_item.find('a.favorite-template').addClass('active');
                            if(template_recently_item)
                                template_recently_item.find('a.favorite-template').addClass('active');
                        }
                    }
                }
            });
        }
        // select template
        else if ($(event.target).closest('.vjs-control-bar').length == 0) {
            // if folder
            if ($(event.target).closest('.is-set').length) {
                reset_videos_on_change();
                const template_id = getAttrData($(this), 'template-id');
                const template_set = getAttrData($(this), 'template-set');
                const video_name = $(this).find('.display-name').text();
                tab = $('.list-template-nav .nav-item').index($('.list-template-nav .nav-item .active').parent());
                template_paging_index(modal_id, tab, 1, after_video_loading, template_id, template_set);
                $('.list-template-nav .active').addClass('is-set'); // mark the tab to show a selected set
            }
            else if (modal_id == '#add-video') { // index page
                $(this).parents('.list-template').find('.video-item').removeClass('checked');
                $(this).addClass('checked');
                $(this).parents('.modal').find('.modal-bottom-button .error-message').addClass('hidden_class');
                $('#template_id').attr('value', getAttrData($(this), 'template-id'));
                // show/hide warning if select template(template ae => hide, template ffmpeg => show)
                if (getAttrData($(this), 'template-id').indexOf('ae.') == -1 && $(this).find('.display-warning-info').length > 0) {
                    $('#add-video.modal .modal-warning').addClass('displayed');
                }
                else {
                    $('#add-video.modal .modal-warning').removeClass('displayed');
                }
            }
        }
        var click_item = $(event.target).closest('.video-item');
        if ($(event.target).closest('.vjs-icon-custombutton').length == 0 && !click_item.hasClass('is-set')) {
            var info = '';
            if (click_item.children('.remove-notice-label').length == 1 && getAttrData(click_item, 'template-id')) {
                info = 'このフォーマットは' + click_item.children('input[name="remove-notice-date"]').val() + 'に提供を終了致します。その後、新規選択・編集はできませんのでご注意ください。';
                $('div.modal-main-list').each(function(index, el) {
                    $(this).addClass('modal-bottom-info-adjust-height');
                });
                $(event.target).closest('.modal-body-wrap').addClass('modal-body-wrap-info-adjust-height');
                $('div.modal-bottom-info span').text(info);
                $('div.modal-bottom-info').show();
            }else{
                hideLabelInfo();
            }
        }
    });

    //------------ show/hide tutorial popup ------------//
    $('iframe#tutorial').hide();
    if($('input[name=tutorial_status]').val() == 'True'){
        $('iframe#tutorial').fadeIn();
    }

    $(window).on("load", function(e){
        $('iframe#tutorial').contents().find('body').on('click', '.modal_close', function(){
            if($('iframe#tutorial').contents().find('#modalHide:checked').val() == "on"){
                $.ajax({
                    url: '/tutorial/complete',
                    type: 'POST',
                    data: {
                    },
                    success: function (response) {
                    }
                })
            }
        });
    });
    $(document).on('click', '#userGuide', function(){
        if ($('#tutorial').attr('src') != '/tutorial/tutorial') {
            $('#tutorial').attr('src', '/tutorial/tutorial');
        }
        $('#tutorial').on('load', function(){
            if($('input[name=tutorial_status]').val() == 'False'){
                $('iframe#tutorial').contents().find('label.checkbox').hide();
                $('iframe#tutorial').contents().find('.modal_main').addClass('check_hidden');
            }
        })
        $('iframe#tutorial').fadeIn();
    });
    //------------ end show/hide tutorial popup ------------//

    //------------ reset search items in basic list template popup ------------//
    let badgeItems = [];
    for (let i=0;i<9;i++){
        badgeItems.push([])
    }
    // default hide format search in list template popup
    $('.list-template .drop-down_box').hide();
    /*クリックイベント*/

    /******************process when click format search tab in list template popup**********************/
    $('.list-template .drop-down dl dd').each(function () {
        $(this).on('click', function(e){
            if($(this).hasClass('active') && (e.target.tagName.toLowerCase() == 'button' || e.target.tagName.toLowerCase() == 'p' || e.target.tagName.toLowerCase() == 'span' && e.target.className == 'drop-down-badge')){
                let index = $(this).index();
                $(this).removeClass('active');
                $('.drop-down_box').hide();
                if (e.target.tagName.toLowerCase() == 'button') {
                    badge = $(this).find('.drop-down_box_list').find('input:checked').length;
                    calculate_number_select(this, badge);
                    badgeItems[index] = $(this).find('.drop-down_box_list').find('input:checked');
                }
                else {
                    $(this).find('.drop-down_box_list').find('input:checked').prop('checked', false);
                    $(badgeItems[index]).prop('checked', true);
                }
            }
            else{
                if (e.target.tagName.toLowerCase() == 'p' || e.target.tagName.toLowerCase() == 'span' && e.target.className == 'drop-down-badge') {
                    let index = $('.drop-down dl dd.active').index();
                    $('.drop-down dl dd.active .drop-down_box_list input:checked').prop('checked', false);
                    $(badgeItems[index]).prop('checked', true);
                }
                $('.drop-down dl dd').removeClass('active');
                $(this).addClass('active');
                $('.drop-down_box').hide();
                $(this).find('.drop-down_box').show();
            }
        });
    });
    //「モーダル」【全て解除する】ボタン
    //------------ clear item in specific tab in format search tabs in basic list template popup------------//
    $('.list-template .drop-down_box_button span').on('click', function(){
        var checkedItems = $(this).closest('.drop-down_box').find('.drop-down_box_list').find('input:checked');
        $(checkedItems).prop('checked', false);
        return false;
    });
    //【全て解除する】ボタン
    //------------ clear all items in all format search tabs in basic list template popup------------//
    $('.list-template .drop-down_box_cancel span').on('click', function(){
        var items = $('.list-template .drop-down').find('.drop-down_box_list').find('input');
        $(items).prop('checked', false);
        $('.drop-down-badge').remove();
        for (let i=0;i<9;i++){
            badgeItems[i] = []
        }
        $('.modal-search-input input').val('');
        $('.modal-search select').val('0');
        $('#color_filter').prop('checked', false);
        $('#cta_filter').prop('checked', false);
        // call search default basic tab after clearing all
        template_paging_index(modal_id, 0, 1, after_video_loading);
        return false;
    });

    //------------ calculate badge in specific tab in format search tabs in basic list template popup------------//
    function calculate_number_select(parent, badge) {
        $(parent).find('.drop-down-badge').remove();
        if (badge > 0) {
            $(parent).find('p:first').prepend(`<span class="drop-down-badge">${badge}</span>`);
        }
    }

    //キーワードのキャンセルタボン
    //------------ clear keyword search in format search tabs in basic list template popup------------//
    $(`${modal_id} .modal-search-delete`).on('click', function(){
        $(`${modal_id} .modal-search-input input`).val('');
        search_template_by_filter(1, after_video_loading);
        return false;
    });
    //「モーダル」【全て解除する】ボタン
    //------------ submit search in format search tabs in basic list template popup------------//
    $('.list-template .drop-down_box_button button, .list-template .modal-search-submit').on('click', function(e){
        e.preventDefault();
        search_template_by_filter(1, after_video_loading);
    });
    $(`${modal_id} .modal-search-input input`).on('keypress', function(e){
        if(e.which == 13) {
            e.preventDefault();
            search_template_by_filter(1, after_video_loading);
        }
    })
    $(`${modal_id} .modal-search select`).on('change', function(e){
        search_template_by_filter(1, after_video_loading);
    })
    $('.list-template .modal-search #color_filter').on('change', function(e){
        search_template_by_filter(1, after_video_loading);
    })
    //------------ end submit search in format search tabs in basic list template popup------------//

    //------------show error edit page modal------------//
    if ($('#error-template-edit-page-modal').length > 0) {
        $('#error-template-edit-page-modal').modal('show');
    }

/******************Process preview and download video popup**********************/
    // download and update
    $(document).on('click', '.download-video', function () {
        if ($('#download-limit').text() === '0') {
            showOutOfDownloadModal();
        } else {
            if ($(this).data('unlimited') !== 'True') {
                disableDownloadButton();
            } else {
                enableDownloadButton();
            }
            showDownloadModal();
        }
        return false;
    });

    $(document).on('click', '.confirm-plan-btn', function () {
        $('.modal').modal('hide');
        setTimeout(function(){ $('#confirm-plan-modal').modal('show'); }, 500);
    });

    $(document).on('click', '.addition-download-btn', function () {
        $('.modal').modal('hide');
        setTimeout(function(){ $('#addition-download-modal').modal('show'); }, 500);
    });

    //------------ download thumbnail in download thumbnail modal and download gif in export modal------------//
    $(document).on('shown.bs.modal', '#preview-generated-video-modal', function(event) {
        let canvas = $('.preview-canvas').get(0);
        if (canvas) {
            const context = canvas.getContext('2d');
            context.clearRect(0, 0, canvas.width, canvas.height);
        }
        let preview_src = $('#preview-generated-video-modal video').attr('src') ? $('#preview-generated-video-modal video').attr('src') : $('#preview-generated-video-modal video source').attr('src');
        let download_src = $('#download-thumbnail-video-modal video').attr('src');
        if (preview_src !== null && preview_src !== undefined && preview_src !== download_src && (preview_src.includes('.mp4') || preview_src.includes('.mov'))) {
            $('#download-thumbnail-video-modal video').attr('src', preview_src);
        }
        if ($('#download-thumbnail-video-modal video').attr('preload') == 'none') {
            $('#download-thumbnail-video-modal video').attr('preload', 'metadata');
        }
        let video = $('#preview-generated-video-modal video').get(0);
        video.volume = bgmHelper.getValueVolume();
        video.addEventListener('volumechange', function(el){
            var volume = el.target.volume;
            bgmHelper.setValueVolumm(volume);
        });
    })

    $(document).on('shown.bs.modal', '#download-thumbnail-video-modal', function(event) {
        let video = $('#download-thumbnail-video-modal video').get(0);
        modal_id = '#download-thumbnail-video-modal';
        video.volume = bgmHelper.getValueVolume();
        video.addEventListener('volumechange', function(el){
            var volume = el.target.volume;
            bgmHelper.setValueVolumm(volume);
        });
    });

    $(document).on('hidden.bs.modal', '#download-thumbnail-video-modal', function(event) {
        let video = $('#download-thumbnail-video-modal video').get(0);
        if (video) {
            video.pause();
        }
        $(this).find('.preview-warning-message').addClass('hidden_class');
        $(this).find('button.btn-download-thumbnail-video').removeAttr('disabled');
    })
    $(document).on('click', '#download-video-modal input#download-check', function(event) {
        if (this.checked) {
            $('#download-video-modal a.download').attr('disabled', false);
        }
        else {
            $('#download-video-modal a.download').attr('disabled', true);
        }
    })
    $(document).on('click', '.btn-preview-canvas', function(event) {
        let canvas = $('.preview-canvas').get(0);
        let video = $('#download-thumbnail-video-modal video').get(0);
        current_time_capture = video.currentTime;
        let height = video.videoHeight;
        let width = video.videoWidth;
        let FIXED_SIZE = 165;
        if (width > height) {
            canvas.height = FIXED_SIZE * height / width;
            canvas.width = FIXED_SIZE;
        }
        else {
            canvas.width = FIXED_SIZE * width / height;
            canvas.height = FIXED_SIZE;
        }
        let ctx = canvas.getContext('2d');
        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
    })

    // Show download thumbnail video modal
    $(document).on('click', '.download-thumbnail-video', function (event) {
        $('.modal').modal('hide');
        setTimeout(function(){
            $('#download-thumbnail-video-modal').modal('show');
            let video = $('#preview-generated-video-modal video').get(0);
            video.crossorigin = "anonymous";
            video.pause();
        }, 500);
        var resolution = getResolution();

        if (resolution && resolution.includes('_GIF') === false) {
            resolution = resolution.split('_')[0] + '_GIF';
        }
        var resolution_value = get_gif_resolutions(resolution);
        $('#download-thumbnail-video-modal .resolution_horizontal_input').val(resolution_value["max"]["horizontal"]);
        $('#download-thumbnail-video-modal .resolution_vertical_input').val(resolution_value["max"]["vertical"]);
        $('#download-thumbnail-video-modal .resolution_vertical_input').val(resolution_value["max"]["vertical"]);
    });

    function check_resolution(resolution) {
        var resolution_value = '';
        if (resolution.includes('_Custom')) {
            resolution_value = get_custom_resolutions(resolution);
        }
        else {
            resolution_value = get_gif_resolutions(resolution);
        }
        return resolution_value;
    }

    function onResolutionInputBlur(event) {
        const modal = $('#select-size-video-export-modal');
        const horizontal = modal.find('.resolution_horizontal_input');
        const vertical = modal.find('.resolution_vertical_input');
        check_video_size_for_watermark(horizontal.val(), vertical.val(), true);
    }

    $(document).on('blur', '.resolution_horizontal_input, .resolution_horizontal_input', onResolutionInputBlur);
    $(document).on('blur', '.resolution_vertical_input, .resolution_vertical_input', onResolutionInputBlur);

    $(document).on('focusout', '#select-size-video-export-modal .resolution_horizontal_input, #download-thumbnail-video-modal .resolution_horizontal_input', onResolutionInputFocusOut);
    $(document).on('focusout', '#select-size-video-export-modal .resolution_vertical_input, #download-thumbnail-video-modal .resolution_vertical_input', onResolutionInputFocusOut);

    function onResolutionInputFocusOut(event) {
        const resolution = getResolution();
        const resolutionValue = check_resolution(resolution);

        let modal = $('#select-size-video-export-modal');
        if ($('#download-thumbnail-video-modal').is(':visible')) {
            modal = $('#download-thumbnail-video-modal');
        }

        const horizontal = modal.find('.resolution_horizontal_input');
        const vertical = modal.find('.resolution_vertical_input');

        let showWarning = false;

        const horizontalValue = horizontal.val();
        const verticalValue = vertical.val();

        if (horizontalValue < resolutionValue["min"]["horizontal"] || horizontalValue == "" ||
            verticalValue < resolutionValue["min"]["vertical"] || verticalValue == ""
        ) {
            horizontal.val(resolutionValue["min"]["horizontal"]);
            vertical.val(resolutionValue["min"]["vertical"]);
        } else if (horizontalValue > resolutionValue["max"]["horizontal"] || verticalValue > resolutionValue["max"]["vertical"]) {
            horizontal.val(resolutionValue["max"]["horizontal"]);
            vertical.val(resolutionValue["max"]["vertical"]);
        } else {
            showWarning = isNaN(horizontalValue) || isNaN(verticalValue);
        }

        show_or_hide_gif_warning_message(event.target, horizontalValue, showWarning, '※ 半角数字で入力してください。');
        disable_export_button_while_error(event.target, showWarning);
        round_resolution(event.target);
        check_video_size_for_watermark(horizontal.val(), vertical.val());
    }

    $(document).on('keyup', '.resolution_horizontal_input', function (event) {
        var resolution = getResolution();
        var resolution_value = check_resolution(resolution);
        var horizontal = $(this);
        var vertical = $(this).closest('.modal-body').find('.resolution_vertical_input');
        var is_show_warning = false;
        if(horizontal.val() > resolution_value["max"]["horizontal"]){
            horizontal.val(resolution_value["max"]["horizontal"]);
            is_show_warning = true;
        }
        else if (horizontal.val() < resolution_value["min"]["horizontal"]){
            if (horizontal.val() < 0){
                horizontal.val(resolution_value["min"]["horizontal"]);
            }
            is_show_warning = true;
        }
        if (horizontal.val() != ""){
            vertical.val(Math.round(horizontal.val() / calculate_resolution_ratio(resolution)));
        }
        else {
            vertical.val("");
            is_show_warning = true;
        }
        if (isNaN($(this).val())) {
            is_show_warning = true;
            show_or_hide_gif_warning_message(this, resolution_value, is_show_warning, '※ 半角数字で入力してください。');
        }
        else {
            show_or_hide_gif_warning_message(this, resolution_value, is_show_warning);
        }
        disable_export_button_while_error(this, is_show_warning);
        check_video_size_for_watermark(horizontal.val(), vertical.val());
    });

    $(document).on('keyup', '.resolution_vertical_input', function (event) {
        var resolution = getResolution();
        var resolution_value = check_resolution(resolution);
        var horizontal = $(this).closest('.modal-body').find('.resolution_horizontal_input');
        var vertical = $(this);
        var is_show_warning = false;
        if(vertical.val() > resolution_value["max"]["vertical"]){
            vertical.val(resolution_value["max"]["vertical"]);
            is_show_warning = true;
        }
        else if (vertical.val() < resolution_value["min"]["vertical"]){
            if (vertical.val() < 0){
                vertical.val(resolution_value["min"]["vertical"]);
            }
            is_show_warning = true;
        }
        if (vertical.val() != ""){
            horizontal.val(Math.round(vertical.val() * calculate_resolution_ratio(resolution)));
        }
        else {
            horizontal.val("");
            is_show_warning = true;
        }
        if (isNaN($(this).val())) {
            is_show_warning = true;
            show_or_hide_gif_warning_message(this, resolution_value, is_show_warning, '※ 半角数字で入力してください。');
        }
        else {
            show_or_hide_gif_warning_message(this, resolution_value, is_show_warning);
        }
        disable_export_button_while_error(this, is_show_warning);
        check_video_size_for_watermark(horizontal.val(), vertical.val());
    });

    function generate_video_thumbnail_image(createThumbnailVideo) {
        let canvas = document.createElement('canvas');
        let context = canvas.getContext("2d");
        canvas.width = parseInt($('#download-thumbnail-video-modal .resolution_horizontal_input').val());
        canvas.height = parseInt($('#download-thumbnail-video-modal .resolution_vertical_input').val());
        context.drawImage(createThumbnailVideo, 0, 0, canvas.width, canvas.height);
        try {
            $('.download-thumbnail-video-link').attr('href', canvas.toDataURL("image/png"));
            let name = $('#download-video-modal a.download').attr('download-name').replace('.gif', '.png').replace('.mp4', '.png').replace('.mov', '.png').replace('.wmv', '.png').replace('.avi', '.png').split("?")[0].split("&")[0];
            let xhr = new XMLHttpRequest();
            xhr.responseType = 'blob';
            xhr.onload = function () {
                let a = document.createElement('a');
                a.href = window.URL.createObjectURL(xhr.response);
                a.download = name;
                a.style.display = 'none';
                document.body.appendChild(a);
                a.click();
                a.remove()
              };
            xhr.open('GET', canvas.toDataURL("image/png"));
            xhr.send();
        }
        catch(err) {
            console.log(err);
        }
    }

    // Show download thumbnail video modal
    $(document).on('click', '#preview-generated-video-modal .btn-download-thumbnail-video', function (event) {
        let video = $('#preview-generated-video-modal video').get(0);
        video.pause();
        video.crossOrigin = 'anonymous';
        video.currentTime = isFinite(current_time_capture)?current_time_capture:0;
        setTimeout(function() {
            generate_video_thumbnail_image(video);
        }, 300);
    });

    // Show download thumbnail video modal
    $(document).on('click', '#download-thumbnail-video-modal .btn-download-thumbnail-video', function (event) {
        let video = $('#download-thumbnail-video-modal video').get(0);
        video.pause();
        video.crossOrigin = 'anonymous';
        video.currentTime = isFinite(current_time_capture)?current_time_capture:0;
        setTimeout(function() {
            generate_video_thumbnail_image(video);
        }, 300);
    });

    //------------ end download thumbnail in download thumbnail modal and download gif in export modal------------//
});

function showInvalidContractModal() {
    $('.modal').modal('hide');
    $('#download-video-modal #downloadable-content').css('display', 'none');
    $('#download-video-modal #over-download-limit-content').css('display', '');
    setTimeout(function(){ $('#download-video-modal').modal('show'); }, 500);
}
//--------------for user profile modal-----------//
function updateContractInfoHeader(is_unlimit_download, downloadable_count) {
    if (!is_unlimit_download) {
        $("#header #download-balance #download-limit").text(downloadable_count);
    }
}
function updateContractInfo(downloadable_count, max_download, is_unlimit_download, plan_name, expiration_date, download_deadline){
    if(!is_unlimit_download && parseInt($("#download_limit").val()) != downloadable_count){
        $("#download_limit").val(downloadable_count);
        $("#header #download-balance #download-limit").text(downloadable_count);
        $('#downloadable-content .plan dd').html('<span id="download-video-modal-remining-count">' + downloadable_count + '</span>');
        $('#confirm-plan-modal .plan dd').html('<span id="confirm-plan-modal-remining-count">0</span>');
    }
}

//--------------for download video modal-----------//
function disableDownloadButton() {
    $('#download-video-modal .download-checkbox-group input[type="radio"]').prop('checked', false);
    $('#download-video-modal a.download').attr('disabled', true);
}
function enableDownloadButton() {
    $('#download-video-modal .download-checkbox-group input[type="radio"]').prop('checked', true);
    $('#download-video-modal a.download').attr('disabled', false);
}
function showDownloadModal() {
    $('.modal').modal('hide');
    var download_limit = $('#download_limit').val();
    if (isNumeric(download_limit) && parseInt(download_limit) > 0) {
        $('#download-video-modal #downloadable-content').css('display', '');
        $('#download-video-modal #over-download-limit-content').css('display', 'none');
    } else {
        $('#download-video-modal #downloadable-content').css('display', 'none');
        $('#download-video-modal #over-download-limit-content').css('display', '');
    }
    setTimeout(function(){ $('#download-video-modal').modal('show'); }, 500);
}

function showDownloadWithPreviewModal(isGif) {
    $('.modal').modal('hide');
    var download_limit = $('#download_limit').val();
    if (isNumeric(download_limit) && parseInt(download_limit) > 0) {
        $('#download-video-with-preview-modal #downloadable-content').css('display', '');
        $('#download-video-with-preview-modal #over-download-limit-content').css('display', 'none');
    } else {
        $('#download-video-with-preview-modal #downloadable-content').css('display', 'none');
        $('#download-video-with-preview-modal #over-download-limit-content').css('display', '');
    }
    setTimeout(function(){
        $('#download-video-with-preview-modal').modal('show');
        if (!isGif) {
            const videoTag = $('#download-video-with-preview-modal video').get(0);
            videoTag.addEventListener("volumechange", changeVolume);
            videoTag.volume = bgmHelper.getValueVolume();
            videoTag.currentTime = 0;
            videoTag.play();
        }
    }, 500);
}

$(document).on('hidden.bs.modal', '#download-video-with-preview-modal', function (event) {
    const video = $('#download-video-with-preview-modal video').get(0);
    if (video && video.currentTime > 0 && !video.paused && !video.ended && video.readyState > 2) {
        video.removeEventListener("volumechange", changeVolume);
        video.pause();
    }
});

function showOutOfDownloadModal() {
    $('.modal').modal('hide');
    setTimeout(function(){ $('#out-of-download-modal').modal('show'); }, 500);
}
/******************End process preview and download video popup**********************/

/******************Calculate tab content height width in list template popup **********************/
function calculateTabContent() {
    if ($(modal_id).hasClass('in')) {
        var height = $(modal_id + ' .modal-body').height() - $('.modal-body .list-template-nav').height() - 50;
        if (modal_id == '#change-template-modal') {
            height += 20;
            if (tab == 0) {
                height -= $('.modal-body .drop-down').height() + $('.modal-body .modal-search').height() + 10 + 20 + 5;
                $('.list-template .tab-content').css('height', height + 'px');
            }
            else {
                $('.list-template .tab-content').css('height', height + 'px');
            }
        }
        else {
            if (tab == 0) {
                height -= $('.modal-body .drop-down').height() + $('.modal-body .modal-search').height() + 20 + 10 + 5;
                $('.list-template .tab-content').css('height', height + 'px');
            }
            else {
                $('.list-template .tab-content').css('height', height + 'px');
            }
        }
    }
    calculateMainContentTopPage();
}

function calculateMainContentTopPage() {
    if (modal_id == '#add-video') {
        var windowHeight = window.innerHeight;
        var minHeight = windowHeight - 50;
        $('#main-content').css('min-height', minHeight + 'px');
    }
}

/******************Check number and size upload in drag&drop, upload media **********************/
function checkNumberAndSizeUpload(files) {
    if (files.length > MAX_NUMBER_UPLOAD) {
        // show message
        setFlash(UPLOAD_WARNING);
        return false;
    }
    let totalSize = 0;
    $.each(files, function( index, valueF ) {
        totalSize += valueF.size;
    })
    if (totalSize > MAX_SIZE_UPLOAD) {
        setFlash(UPLOAD_WARNING);
        return false;
    }
    return true;
}

function isValidPdfFile(file) {
    if (!file || file.size > MAX_PDF_UPLOAD_FILE_SIZE || file.name.split('.').pop().toLowerCase() !== 'pdf') {
        setFlash(UPLOAD_PDF_WARNING);
        return false;
    }
    return true;
}

/******************Check contract status **********************/
function check_contract_status(){
    $.ajax({
        'url': '/check_contract_status',
        'type': 'GET',
        'dataType': 'json',
        'success': function (response) {
            if(!response.result){
                location.reload();
            }
        },
    });
}

/******************Get current minute and second for check video  **********************/
function getCurrentTimeByMinuteSecond() {
    var today = new Date();
    return [today.getMinutes(), today.getSeconds()];
}

function timer(ms) {
    return new Promise(res => setTimeout(res, ms));
}
// count number by author Jesse Hazel
// http://jsfiddle.net/jwhazel/4JsY3/
(function($) {
    $.fn.countTo = function(options) {
        // merge the default plugin settings with the custom options
        options = $.extend({}, $.fn.countTo.defaults, options || {});

        // how many times to update the value, and how much to increment the value on each update
        var loops = Math.ceil(options.speed / options.refreshInterval),
            increment = (options.to - options.from) / loops;

        return $(this).each(function() {
            var _this = this,
                loopCount = 0,
                value = options.from,
                interval = setInterval(updateTimer, options.refreshInterval);

            function updateTimer() {
                value += increment;
                loopCount++;
                var oldValue = parseInt($(_this).text());
                if (oldValue < value) {
                    if (options.isPercent) {
                        $(_this).html(value.toFixed(options.decimals) + '%');
                    }
                    else {
                        $(_this).html(value.toFixed(options.decimals));
                    }
                }

                if (typeof(options.onUpdate) == 'function') {
                    options.onUpdate.call(_this, value);
                }

                if (loopCount >= loops) {
                    clearInterval(interval);
                    value = options.to;

                    if (typeof(options.onComplete) == 'function') {
                        options.onComplete.call(_this, value);
                    }
                }
            }
        });
    };

    $.fn.countTo.defaults = {
        from: 0,  // the number the element should start at
        to: 100,  // the number the element should end at
        speed: 1000,  // how long it should take to count between the target numbers
        refreshInterval: 100,  // how often the element should be updated
        decimals: 0,  // the number of decimal places to show
        isPercent: true, // Add % character at the end
        onUpdate: null,  // callback method for every time the element is updated,
        onComplete: null,  // callback method for when the element finishes updating
    };
})(jQuery);

// get type resolution of video, return Horizontal_GIF, Square_GIF, Vertical_GIF
function getResolution() {
    function getResolutionBySize(videoWidth, videoHeight) {
        if (videoWidth > videoHeight) {
            return 'Horizontal_GIF';
        }
        else if (videoWidth == videoHeight) {
            return 'Square_GIF';
        }
        else {
            if (parseInt(videoWidth)/parseInt(videoHeight) == 4/5)
                return 'Vertical45_GIF';
            return 'Vertical_GIF';
        }
    }
    if (modal_id === '#add-video') {
        let video = $('#preview-generated-video-modal video').get(0);
        let videoHeight = video.videoHeight;
        let videoWidth = video.videoWidth;
        return getResolutionBySize(videoWidth, videoHeight);
    }
    else {
        let resolution = null;
        if (modal_id === '#download-thumbnail-video-modal') {
            resolution = $('#download-thumbnail-video-modal').data('resolution');
        }
        if (resolution) {
            return resolution;
        }
        let resolutionElement = $('#select-size-video-export-modal select[name="size_video_id"]').parent().find('ul.option');
        if (resolutionElement.length == 0) {
            if ("video" in options_template && "aspect" in options_template["video"]) {
                let sizes = options_template["video"]["aspect"].split(":");
                return getResolutionBySize(sizes[0],size[1]);
            }
        }
        resolution = resolutionElement.find('li.active').data('value');
        if (!resolution) {
            resolution = resolutionElement.find('li:last').data('value');
        }
        return resolution;
    }
}
function calculate_resolution_ratio(resolution){
    var video_ratio = 1;
    if(resolution.search('_GIF') != -1){
        var max_resolutions = video_resolutions["max"];
    }else {
        var max_resolutions = custom_video_resolutions["max"];
    }
    if (resolution in max_resolutions){
        video_ratio = max_resolutions[resolution]["horizontal"] / max_resolutions[resolution]["vertical"];
    }
    return video_ratio;
}

function get_gif_resolutions(resolution){
    var resolution_value = {
        "max": {
            "horizontal": -1,
            "vertical": -1
        },
        "min": {
            "horizontal": -1,
            "vertical": -1
        },
        'default': {
            "horizontal": -1,
            "vertical": -1
        }
    }
    if (resolution in video_resolutions["max"]){
        resolution_value["max"] = video_resolutions["max"][resolution];
    }
    if (resolution in video_resolutions["min"]){
        resolution_value["min"] = video_resolutions["min"][resolution];
    }

    if (resolution in video_resolutions["min"]){
        resolution_value["default"] = video_resolutions["default"][resolution];
    }
    return resolution_value;
}

function get_custom_resolutions(resolution){
    var resolution_value = {
        "max": {
            "horizontal": -1,
            "vertical": -1
        },
        "min": {
            "horizontal": -1,
            "vertical": -1
        },
        'default': {
            "horizontal": -1,
            "vertical": -1
        }
    }

    if (resolution in custom_video_resolutions["max"]){
        resolution_value["max"] = custom_video_resolutions["max"][resolution];
    }
    if (resolution in custom_video_resolutions["min"]){
        resolution_value["min"] = custom_video_resolutions["min"][resolution];
    }

    if (resolution in custom_video_resolutions["min"]){
        resolution_value["default"] = custom_video_resolutions["default"][resolution];
    }
    return resolution_value;
}


function show_or_hide_gif_warning_message(el, resolution_value, is_show, message){
    if (is_show == true){
        if (message == undefined) {
            message = "※ この動画は最小";
            message += resolution_value["min"]["horizontal"] + " × " + resolution_value["min"]["vertical"] + " 、最大";
            message += resolution_value["max"]["horizontal"] + " × " + resolution_value["max"]["vertical"] + "の範囲で指定してください。";
        }
        // export
        if ($(el).closest('.gif-video-box').length > 0) {
            $('#select-size-video-export-modal #gif-warning-message').text(message);
            $('#select-size-video-export-modal #gif-resolution-warning').removeClass('hidden_class');
        }
        // preview
        else {
            $('.preview-warning-message').removeClass('hidden_class').text(message);
        }
    }
    else {
        if ($(el).closest('.gif-video-box').length > 0) {
            $('#select-size-video-export-modal #gif-resolution-warning').addClass('hidden_class');
            $('#select-size-video-export-modal #gif-warning-message').text("");
        }
        // preview
        else {
            $('.preview-warning-message').addClass('hidden_class');
        }
    }
}

function round_resolution(el){
    let parent = $(el).closest('.modal-body');
    let horizontal = parent.find('.resolution_horizontal_input');
    let vertical = parent.find('.resolution_vertical_input');
    var resolution_h = parseInt(horizontal.val());
    if (resolution_h %2 != 0){
        resolution_h += 1;
        horizontal.val(resolution_h);
    }

    var resolution_v = parseInt(vertical.val());
    if (resolution_v %2 != 0){
        resolution_v += 1;
        vertical.val(resolution_v);
    }
}

function disable_export_button_while_error(el, is_show_warning) {
    if (is_show_warning) {
        if ($(el).closest('.gif-video-box').length > 0) {
            $('#select-size-video-export-modal .btn-export').prop("disabled", true);
        }
        else {
            $('.btn-download-thumbnail-video').prop("disabled", true);
        }
    }
    else {
        if ($(el).closest('.gif-video-box').length > 0) {
            $('#select-size-video-export-modal .btn-export').prop("disabled", false);
        }
        else {
            $('.btn-download-thumbnail-video').prop("disabled", false);
        }
    }
}

function progress_bar_animation(el, speed) {
    if (speed == null) {
        speed = 1200;
    }
    let oldData = getAttrData($(el), 'old-percent');
    let newData = getAttrData($(el), 'percent');
    if (parseInt(oldData) < parseInt(newData)) {
        $(el).animate({
            width: (newData + "%") // or + "%" if fluid
        }, speed);
    }
}
function progress_text_animation(el, to, isPercent){
    let from = parseInt($(el).text());
    if (from < to) {
        $(el).countTo({
            from: from,
            to: to,
            speed: 1200,
            refreshInterval: 50,
            isPercent: isPercent,
            onComplete: function (value) {
                console.debug(this);
            }
        });
    }
}

function sentry_capture_message(data, extra, message) {
    Sentry.withScope(scope => {
        if (Array.isArray(data))
        {
            let i = 0;
            for (let datum of data){
                if (typeof datum == 'string') {
                    if (datum.length >= 16000 && datum.length <= 1024 * 1024) {
                        let stringArray = datum.split('\n');
                        for (let j = 0; j < stringArray.length; j++) {
                            if (stringArray[j].trim().length > 0) {
                                i++;
                                scope.setExtra(extra + i.toString().padStart(5, "0"), stringArray[j]);
                            }
                        }
                    }
                }
                else {
                    scope.setExtra(extra + i.toString().padStart(5, "0"), datum);
                    i++;
                }
            }
        }
        else scope.setExtra(extra, data);
        Sentry.captureMessage(message);
    });
}

function check_sc_items(sc_items){
    var error = false;
    try{
        if(sc_items.sc_id === undefined || sc_items.sc_id.length == 0){
            error = true;
        }
        if(sc_items.template_id === undefined || sc_items.template_id.length == 0){
            error = true;
        }
        if(sc_items.slide_idx !== undefined){
            var slide_num = $('#main-content .scene > ul > li div[class^=slide-index-]').length;
            if(sc_items.slide_idx >= slide_num){
                error = true
            }
        }
        if(error){
            sentry_capture_message(sc_items, 'response', `Check sc_items`);
        }
    }catch(err){
        sentry_capture_message([err, sc_items], 'exception and response', `Check sc_items`);
    }
}

var after_video_loading = function (modal_id, video=null) {
    // add checked in edit page
    if (video) {
        if (modal_id == '#change-template-modal') {
            var data_id = getAttrData($('#main-content'), 'template-id');
            var parentItem = video.closest('.video-item');
            if (parentItem) {
                var data_template = getAttrData($(parentItem), 'template-id');
                if (data_id == data_template) {
                    parentItem.classList.add('checked');
                }
            }
        }
    }
    else {
        $(`${modal_id} .modal-body-tab[tab-content="${tab}"] .modal-main-list`).animate({scrollTop: 0}, 500);
    }
}
//------------ search in format search tabs in basic list template popup------------//
function search_template_by_filter(page, after_video_loading, forced) {
    let {dataFilter, is_valid} = getParamSearch();

    function callSearchTemplateAjax() {
        let tab = 0;
        $('.template-bgm__switch .template-bgm__toggle').prop('disabled', true);
        if (is_valid) {
            page = isNumeric(page)?page:1;
            let modal_main = $(modal_id + ' #template-basic .modal-main');
            setAttrData($(modal_id + ' #template-basic'), 'page', page);
            if(search_template_xhr && search_template_xhr.readyState !== 4){
                search_template_xhr.abort();
            }
            stopAllVideos();
            let video_template = null;
            if (modal_id === '#change-template-modal') {
                video_template = getAttrData($(modal_id), 'template-id');
            }
            search_template_xhr = $.ajax({
                url: '/get_paged_template_list',
                type: 'GET',
                cache: false,
                headers: {"X-CSRFToken": getCookie("csrftoken")},
                beforeSend: function () {
                    modal_main.children().addClass('hidden_class');
                    const activeTab = $('.modal-sidebar-list li.clearfix.active span');
                    if (activeTab.length !== 1) {
                        modal_main.append(getLoadingAnimationFormatListHtml('loading-animation-filter-tab'));
                    } else {
                        let loadingAnimationSize = parseInt(activeTab[0].innerText);
                        if (!loadingAnimationSize || loadingAnimationSize > videoPageSize) {
                            modal_main.append(getLoadingAnimationFormatListHtml('loading-animation-filter-tab'));
                        } else {
                            modal_main.append(getLoadingAnimationFormatListHtml('loading-animation-filter-tab', loadingAnimationSize));
                        }
                    }
                },
                data: {
                    'page': page,
                    'tab': tab,
                    'video_template': video_template,
                    'filter': JSON.stringify(dataFilter)
                },
                success: function (response) {
                    modal_main.find('div.loading-animation-container').remove();
                    modal_main.children().removeClass('hidden_class');
                    var modal_id_content = modal_id + ' #template-basic .modal-main-list .tab-pane';

                    var videoItems = document.querySelectorAll(modal_id_content + ' video');
                    for (i = 0; i < videoItems.length; i++) {
                        run_videojs_and_handle_error(videoItems[i]).dispose();
                    }
                    $(modal_id_content).empty();
                    if (response.length > 0) {
                        $('.template-list-folder').hide();
                        $('.list-template .tab-content').css('overflow-y', 'scroll');
                        $(modal_id_content).append(response);
                        var videoItems = document.querySelectorAll(modal_id_content + ' video');
                        if (after_video_loading != null) {
                            after_video_loading(modal_id);
                        }
                        loadGroupVideojs(videoItems, modal_id, after_video_loading);
                        $('#template-basic .modal-sidebar-list').html($('.template_list_number').html());
                    }
                    else {
                        $('#template-basic .modal-sidebar-list').html('');
                        $('#template-basic .modal-sidebar-list').append('<ul><li class="clearfix active" data-id="-1"><p>全てのカテゴリ</p><span>0</span></li></ul>');
                    }
                    setTimeout(function(){ bgmHelper.changeMutedTemplate('.template-bgm .template-bgm__toggle'); }, 2000);
                    $('.template-bgm__switch .template-bgm__toggle').prop('disabled', false);
                    template_name_tooltip();
                }
            })
        }
        else {
            template_paging_index(modal_id, tab, page, after_video_loading);
        }
    }

    if (forced || JSON.stringify(dataFilter) !== search_data_filter || search_template_current_page !== page) {
        search_data_filter = JSON.stringify(dataFilter);
        search_template_current_page = page;
        callSearchTemplateAjax();
    }
}

function getConditonfilter() {
    let category = {};
    let select_group_wrapper = '.modal-refine-list > div';
    let select_group = 'ul li input';
    $(select_group_wrapper).each(function () {
        $(this).find(select_group).each(function () {
            if ($(this).prop('checked')) {
                is_valid = true;
                let data_cat = getAttrData($(this), 'cat');
                if (category[data_cat] == undefined) {
                    category[data_cat] = []
                }
                if (getAttrData($(this), 'id')) {
                    category[data_cat].push(getAttrData($(this), 'id'));
                }
                // Event tracking sending a single condition of format search condition
                gtag('event', data_cat, {
                    'event_category': 'Format Search Single',
                    'event_label': $(this).next('label').text(),
                    'value': 1
                });
                if (eventTracking.length > 0) {
                    eventTracking += '&';
                }
                eventTracking += `${data_cat}=${$(this).next('label').text()}`;
            }
        })
    });
    return category;
}
function getParamSearch() {
    let dataFilter = {}, is_valid = false;
    eventTracking = '';
    let input_search = '.modal-sidebar-search input';
    dataFilter['category'] = getConditonfilter();
    dataFilter['keyword'] = $(input_search).val().trim();
    if (dataFilter['keyword']) {
        is_valid = true;
        // Event tracking sending a single condition of format search condition
        gtag('event', 'keyword', {
            'event_category': 'Format Search Single',
            'event_label': dataFilter['keyword'],
            'value': 1
        });
        if (eventTracking.length > 0) {
            eventTracking += '&';
        }
        eventTracking += 'keyword='+dataFilter['keyword'];
    }
    if (parseInt($('.modal-search select').val()) !== parseInt($('.modal-search select').data('old'))) {
        is_valid = true;
        $('.modal-search select').data('old', $('.modal-search select').val());
    }

    dataFilter['sort'] = $('.modal-search select').val();

    if ($('#color_filter').prop('checked')) {
        is_valid = true;
    }
    dataFilter['color_filter'] = $('#color_filter').prop('checked');
    dataFilter['cta_filter'] = $('#cta_filter').prop('checked');
    if ($('.modal-sidebar-list').length > 0) {
        is_valid = true;
        if ($('.modal-sidebar-list ul li.active').length > 0) {
            dataFilter['specific_use'] = $('.modal-sidebar-list ul li.active').data('id');
        }
        else {
            dataFilter['specific_use'] = -1;
        }
    }

    if (eventTracking.length > 0) {
        // Event tracking sending multiple conditions of format search condition
        gtag('event', '複合条件', {
            'event_category': 'Format Search Multiple',
            'event_label': eventTracking,
            'value': 1
        });
    }
    return {dataFilter, is_valid};
}
/******************end process when click format search tab in list template popup**********************/
var Button = videojs.getComponent('Button');
var MyButton = videojs.extend(Button, {
    constructor: function() {
        Button.apply(this, arguments);
        /* initialize your button */
    },
    handleClick: function(e) {
        /* do something on click */
        let parent = $(e.currentTarget).closest('.video-item');
        // check fullsize
        let currentVideo = parent.find('video').get(0);
        let video_src = $(currentVideo).attr('src');
        if (video_src === undefined) {
            video_src = $(currentVideo).find('source').attr('src');
        }
        if (parent.hasClass('modal-main-full')) {
            parent.fadeOut();
            let originalVideo = parent.prev().find(`video[src="${video_src}"]`);

            if (originalVideo.length == 0) {
                originalVideo = parent.prev().find(`source[src="${video_src}"]`).parent();
            }
            if (!currentVideo.paused) {
                if (originalVideo.length > 0) {
                    originalVideo.get(0).load();
                    originalVideo.get(0).currentTime = currentVideo.currentTime;
                    originalVideo.get(0).oncanplay  = function(e) {
                        this.play();
                    }
                }
            }
            else {
                if (originalVideo.length > 0) {
                    originalVideo.get(0).load();
                    originalVideo.get(0).oncanplay  = function(e) {
                        this.pause();
                    }
                }
            }
            bgmHelper.setVolumeVideoFull(originalVideo.get(0), currentVideo.muted)

            currentVideo.pause();
            // show main content
            if (parent.hasClass('main-content-full')) {
                $('#main-content').fadeIn();
            }
            let click_item = parent.prev().find('.video-item.checked');
            check_show_expire_warning(click_item);
        }
        // check
        else {
            if (modal_id === "#add-video") {
                const videoContainer = $('#wrap-content')[0];
                videoContainer.scrollBy({
                    top: videoContainer.scrollHeight,
                    left: 0,
                    behavior: 'smooth'
                });
            }

            let {wrapper, fullElement} = getElementVideo(parent);
            let fullVideo = fullElement.find('video');
            fullVideo.attr('src', video_src).attr('preload', 'metadata');
            fullElement.fadeIn();
            fullElement.find('video').get(0).pause();
            if (!currentVideo.paused) {
                fullVideo.get(0).load();
                fullVideo.get(0).currentTime = currentVideo.currentTime;
                fullVideo.get(0).oncanplay = function(e) {
                    this.play();
                }
            }
            else {
                fullVideo.get(0).load();
                fullVideo.get(0).oncanplay = function(e) {
                    this.pause();
                }
            }
            fullVideo.get(0).volume = bgmHelper.getValueVolume();
            bgmHelper.setVolumeVideoFull(fullVideo.get(0), currentVideo.muted);
            $(wrapper).find('video').each(function(){
                $(this).get(0).pause();
            })
            removeAdjustHeightClass();
        }
    },
    buildCSSClass: function() {
        return "vjs-icon-custombutton vjs-control vjs-button";
    }
});
videojs.registerComponent('MyButton', MyButton);

function showHidePasswordInShareLinkModal() {
    if ($('#share-video-modal input.share-password').val().length > 0) {
        $('#share-video-modal .share-password-block').show();
        $('#share-video-modal #password-checkbox').prop('checked', true);
    }
    else {
        $('#share-video-modal .share-password-block').hide();
        $('#share-video-modal #password-checkbox').prop('checked', false);
    }
}
function showCheckboxDownload(is_download, is_watermark_share_url){
    if (parseInt(is_watermark_share_url)) {
        $('#share-video-modal #is-download-checkbox-label').addClass('disabled-label');
        $('#share-video-modal #disable-download-checkbox-warning').css('display', 'block');
    } else {
        $('#share-video-modal #is-download-checkbox-label').removeClass('disabled-label');
        $('#share-video-modal #disable-download-checkbox-warning').css('display', 'none');
    }
    if(parseInt(is_download) && parseInt(is_watermark_share_url) === 0) {
        $('#share-video-modal #is-download-checkbox').prop('checked', true);
    } else {
        $('#share-video-modal #is-download-checkbox').prop('checked', false);
    }
}
function isAllowedExtension(fname) {
    // no extension
    if (fname.indexOf('unsplash') != -1) return true;
    if (fname.lastIndexOf('.') == -1) return true;
    let extension = get_material_extension(fname);
    return MIMES_IMAGE.indexOf(extension) !== -1 || MIMES_UPLOAD_VIDEO.indexOf(extension) !== -1;
}

    //------------ Check load browser ----------//

    function notIE() {
        var ua = window.navigator.userAgent;
        if (ua.indexOf('Edge/') > 0 ||
            ua.indexOf('Trident/') > 0 ||
            ua.indexOf('MSIE ') > 0) {
            return false;
        } else {
            return true;
        }
    }

    function notFireFox() {
        var ua = window.navigator.userAgent;
        if (ua.indexOf("Firefox") > 0) {
            return false;
        } else {
            return true;
        }
    }

function isExtensionNotSupportInBrowser(path) {
    return path.indexOf('.wmv') > 0 || path.indexOf(".avi") > 0 || path.indexOf(".mov") > 0;
}

function get_video_file_extension(video_src) {
    let extension = video_src.substr(video_src.lastIndexOf('/')).toLowerCase().split('?')[0];
    extension = extension.substr(extension.lastIndexOf('.')).toLowerCase();
    return extension;
}

function removeActiveElementInList(list_el) {
    for (i = 0; i < list_el.length; i++) {
        $(list_el[i]).removeClass('active');
    }
}

function forceDownload(blob, filename) {
  var a = document.createElement('a');
  a.download = filename;
  a.href = blob;
  // For Firefox https://stackoverflow.com/a/32226068
  document.body.appendChild(a);
  a.click();
  a.remove();
}
// Current blob size limit is around 500MB for browsers
function downloadResource(url, filename) {
  if (!filename) filename = url.split('\\').pop().split('/').pop();
  fetch(url, {
      /*
      headers: new Headers({
        'Origin': location.origin
      }),
      mode: 'cors'
       */
      cache: 'no-cache'
    })
    .then(response => response.blob())
    .then(blob => {
      let blobUrl = window.URL.createObjectURL(blob);
      forceDownload(blobUrl, filename);
      setFlash('ダウンロードしました。');
    })
    .catch(e => console.error(e));
}

function count_up_download_video_top_page(video_id, success_callbak){
        $.ajax({
            url: '/countup_download',
            method: "GET",
            'dataType': 'json',
            'data': {'video_data_id': video_id},
            success: function (response) {
                if (success_callbak) {
                    success_callbak(response);
                }
            },
            error: function (response) {
                console.log('Download count up failed. video_id=' + video_id);
            },
        });
    }

$(document).on("click", "#download-video-file-btn", function () {
    let video_url = getAttrData($(this), 'url');
    let video_name = $(this).attr('download-name');
    let video_id = getAttrData($(this), 'id');
    downloadResource(video_url, video_name);
    count_up_download_video_top_page(video_id, function () {
        getPlayerUrl(video_id, true);
    });

    $('.modal').modal('hide');
    return false;
});

$(document).on("click", "#share-download-video-file-btn", function () {
    $('.modal').modal('hide');
    $('#share-video-download-modal .modal-footer .a-btn-disabled').hide();
    $('#share-video-download-modal .modal-footer a').show();
    setTimeout(function(){ $('#share-video-download-modal').modal('show'); }, 500);
});

$(document).on("click", "#share-video-download-modal #confirm-download-video-file-btn", function (event) {
    $(this).hide();
    $('#share-video-download-modal .modal-footer .a-btn-disabled').show();
    const video_share_content = $('.video-share .video-share-content .video');
    let video_url = getAttrData($(video_share_content), 'url');
    let video_name = getAttrData($(video_share_content), 'download-name');
    setTimeout(function(){ $('#share-video-download-modal').modal('hide'); }, 500);
    downloadResource(video_url, video_name);
    let video_hash = getAttrData($(video_share_content), 'video-id');
    countup_download_video_share(video_hash);
    return false;
});

function get_material_sg_path(input_path) {
    if (input_path && input_path.includes('/tmp/')) {
        input_path = 'tmp/' + input_path.split('/tmp/')[1].split('?')[0];
    }
    return input_path;
}

function getElementVideo(parent) {
    let wrapper = null;
    if (isTemplateVideo(parent)) {
        wrapper = parent.closest('.modal-main');
    }
    else if (isGeneratedVideo(parent)) {
        wrapper = parent.closest('#wrap-content');
        wrapper.find('#main-content').fadeOut();
    }
    let fullElement = wrapper ? wrapper.find('.modal-main-full'): null;
    return {wrapper, fullElement};
}

function isTemplateVideo(parent) {
    let wrapper = parent.parents('.list-template');
    return wrapper.length > 0 ? true: false;
}

function isGeneratedVideo(parent) {
    let wrapper = parent.parents('.list-video');
    return wrapper.length > 0 ? true: fales;
}

function convert_date_time_to_string(date_input, format='YYYY-MM-DD_HHmm') {
    let items = date_input.toLocaleString('en-US', {timeZone: Intl.DateTimeFormat().resolvedOptions().timeZone, hourCycle: 'h23', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit'}).replace(/\s/g, '').split(',');
    let date_blocks = items[0].split('/');
    let time_blocks = items[1].split(':');
    let date_output = format;
    date_output = date_output.replace('YYYY', date_blocks[2]);
    date_output = date_output.replace('MM', date_blocks[0]);
    date_output = date_output.replace('DD', date_blocks[1]);
    date_output = date_output.replace('HH', time_blocks[0]);
    date_output = date_output.replace('mm', time_blocks[1]);
    date_output = date_output.replace('ss', time_blocks[2]);
    return date_output;
}

function run_videojs_and_handle_error(input_video, options, alert_message, finish_callback) {
    let player = null;
    let retryCount = 0;
    const maxRetryCount = 3;

    videojs.log.level('off');
    if (options) {
        player = videojs(input_video, options);
    } else {
        player = videojs(input_video);
    }
    player.on('error', function () {
        if (alert_message) {
            alert(alert_message);
        }
        if (retryCount < maxRetryCount) {
            retryCount++;
            const currentTime = player.currentTime();
            player.error(null).pause().load().currentTime(currentTime).play();
            return
        }
        if (finish_callback)
            finish_callback();
        sentry_capture_message([player.currentSrc(), player.error()], 'videojs', 'Call videojs error');
    });
    return player;
}
/****************** loading animation functions **********************/
function getLoadingAnimationFormatListHtml(additionalClasses= null, itemsCount = videoPageSize) {
    const animationItem = `
        <div class="col-md-4 loading-animation-item">
            <div class="loading-animation-content loading-animation-content-list-modal">
                <div class="loading-animation-item-text background-shimmer-animation"></div>
                <div class="loading-animation-item-text background-shimmer-animation"></div>
            </div>
        </div>`;

    let animationHtml = `<div class="loading-animation-container ${additionalClasses ? additionalClasses : ''}">`;

    for (let i = 0; i < itemsCount; i++) {
        animationHtml += animationItem;
    }
    animationHtml += `</div>`;
    return animationHtml;
}

/**
* Check if the given value is an object.
* @param {*} value - The value to check.
* @returns {boolean} Returns `true` if the given value is an object, else `false`.
*/

function isObject(value) {
    return typeof value === 'object' && value !== null;
}

/**
* Get data from the given element.
* @param {Element} element - The target element.
* @param {string} name - The data key to get.
* @returns {string} The data value.
*/

function getAttrData(element, name) {
    if (isObject(element[name])) {
      return element[name];
    }
    return element.attr(`data-${name}`);
}
/**
* Set data to the given element.
* @param {Element} element - The target element.
* @param {string} name - The data key to set.
* @param {string} data - The data value.
*/

function setAttrData(element, name, data) {
    if (isObject(data)) {
      element[name] = data;
    } else {
      // Using .data() will not update DOM so css selector will not work well in some cases so using .attr() will be safer. Refs #RICHIKA-2732.
      element.attr(`data-${name}`, data);
    }
}
/**
* Remove data from the given element.
* @param {Element} element - The target element.
* @param {string} name - The data key to remove.
*/

function removeAttrData(element, name) {
    if (isObject(element[name])) {
      try {
        delete element[name];
      } catch (e) {
        element[name] = undefined;
      }
    } else {
      element.removeData(name);
      element.removeAttr(`data-${name}`);
    }
}

function validateEmail(target, email, isEmail = false) {
    let error_message = null;
    valid_state.email = false;
    if(email.length === 0) {
        if (!isEmail) {
            error_message = 'メールアドレスを入力してください';
        }
    } else if(current_email === email && email.length >= 254) {
        error_message = '最大文字数を超えました。254文字以内で設定してください。';
    } else if(!isValidEmailAddress(email)) {
        error_message = 'メールアドレスの形式が違います';
    } else {
        current_email = email;
        valid_state.email = true;
    }
    $(target).parents('tbody').find('tr:last td').html('');
    $(target).siblings('p').remove();
    if (error_message) {
        if(!isEmail) {
            $(target).after('<p><span class="error-message">' + error_message + '</span></p>');
        }
        else {
            $(target).parents('tbody').find('tr:last td').html(`<ul class="errorlist"><li>${error_message}</li></ul>`);
        }
    }
    checkStateAndUpdateSubmitBtn();
}

function checkTargetInUsedMaterialAndSlide(targetPath) {
    targetPath = get_material_sg_path(targetPath);
    var items = $('#main-content .scene > ul > li div[class^=slide-index-]');
    var isInSlide = false;
    for (let i = 0; i < items.length; i++) {
        var item_src = $(items[i]).find('input[class="srcImageFirst"]').attr('value');
        if (item_src && item_src.includes(targetPath)) {
            isInSlide = true;
            break;
        }
    }
    return isInSlide;
}

function get_scenes_using_image(image_path) {
    image_path = get_material_sg_path(image_path);
    let items = $('#main-content .scene > ul > li div[class^=slide-index-]');
    let scenes = [];
    for (let i = 0; i < items.length; i++) {
        let item_src = $(items[i]).find('input[class="srcImageFirst"]').attr('value');
        if (item_src && item_src.includes(image_path)) {
            scenes.push(i);
        }
    }
    return scenes;
}

function getPlayerUrl(video_id, is_page_index = false){
    $.ajax({
        url: '/ajax_get_player_url',
        type: 'POST',
        data: {
            'video_data_id': video_id,
        },
        dataType: 'json'
    }).done(function(response) {
        if (response.result) {
            if (is_page_index) {
                let video_elem = $(`.list-video .video-item[data-video-id=${video_id}]`);
                let embed_elem = video_elem.find('.info .dropdown-menu li.embed_tag');
                if (embed_elem.hasClass('hidden_class')) {
                    setAttrData(embed_elem.find('a'), 'embed-tag', response.player_url)
                    embed_elem.removeClass('hidden_class');
                }
            }
            else {
                $('#embedIframe').attr('src', response.player_url);
            }
        }
    }).fail((data) => {
        sentry_capture_message(data.responseText, 'response', `Get Player Url Error`);
    });
};

function check_video_size_for_watermark(horizontal_size, vertical_size, is_reset_state) {
    if (!$('#select-size-video-export-modal .gif-video-box').hasClass('hidden_class')) {
        if (horizontal_size < 200 || vertical_size < 200) {
            if (is_reset_state) {
                $('#select-size-video-export-modal #watermark-warning-message').css('display', 'block');
                $('#select-size-video-export-modal .type-watermark-video').addClass('disabled-label')
                $('#select-size-video-export-modal #is-watermark-share-video').prop('checked', false);
                $('#select-size-video-export-modal #is-watermark-embedded-video').prop('checked', false);
                $('#select-size-video-export-modal #watermark-video-select-area').css('display', 'none');
            }
        } else {
            $('#select-size-video-export-modal .type-watermark-video').removeClass('disabled-label');
            $('#select-size-video-export-modal #watermark-warning-message').css('display', 'none');
        }
    } else {
        $('#select-size-video-export-modal .type-watermark-video').removeClass('disabled-label');
        $('#select-size-video-export-modal #watermark-warning-message').css('display', 'none');
    }

}

function validURL(str) {
  var pattern = new RegExp('^(https?:\\/\\/)?'+
    '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+
    '((\\d{1,3}\\.){3}\\d{1,3}))'+
    '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+
    '(\\?[;&a-z\\d%_.~+=-]*)?'+
    '(\\#[-a-z\\d_]*)?$','i');
  return !!pattern.test(str);
}


/**************Get material*****************/
function load_images_from_url_and_pdf_tabs() {
    const pdfList = $('#pdf #list-image-wrapper');
    const urlList = $('#url #list-image-wrapper');
    $.ajax({
        'url': '/get_pdf_url_image_list_edit_page',
        'type': 'GET',
        data: {
            'video_data_id': $('#video_data_id').val(),
        },
        headers: {"X-CSRFToken": getCookie("csrftoken")},
        'success': function (response) {
            pdfList.empty();
            urlList.empty();
            pdfList.html(response['pdf']);
            urlList.html(response['url']);
            setTimeout(function () {
                let activeTab = localStorage.getItem('prev_tab');
                if (activeTab === 'url') {
                    let imageItems = urlList.find('.thumb img');
                    loadGroupImagejs(imageItems, '', null);
                } else if (activeTab === 'pdf'){
                    let imageItems = pdfList.find('.thumb img');
                    loadGroupImagejs(imageItems, '', null);
                }
            }, 1000);
        },
        error: function(err) {
            sentry_capture_message(err.responseText, 'response', `load_images_from_url_and_pdf_tabs`);
        }
    });
}