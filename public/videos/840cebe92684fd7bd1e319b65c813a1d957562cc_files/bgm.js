var BMG_STATUS = {
    ON: 1,
    OFF: 0,
}

var bgmHelper = (function(){
    var _volume = 1;
    var _options = {
        controlBar: {
            volumePanel: {inline: false}
        },
    };

    function getVideoOption() {
        return _options;
    }

    function setValueVolumm(_volume){
        localStorage.setItem('volume_background_music', _volume);
    }

    function getValueVolume() {
        return localStorage.getItem('volume_background_music');
    }

    function setOnMute() {
        localStorage.setItem('mute_background_music', BMG_STATUS.ON);
    }

    function setOffMute() {
        localStorage.setItem('mute_background_music', BMG_STATUS.OFF);
    }

    function getStatusMute() {
        return localStorage.getItem('mute_background_music');
    }

    function getStatusInput(_target) {
        return $(_target).is(':checked');
    }

    function setMutiVideo(video, volume, status) {
        if (status) {
            $(video).attr('muted','muted');
        }
        else {
            $(video).removeAttr('muted');
        }
        $(video).prop('muted', status);
        video.volume = volume;
    }

    function changeMutedTemplate(_target) {
        var listVideo = $('.list-template .video-item .video video');
        var volume = getValueVolume();
        if(getStatusInput(_target)) {
            $('.template-bgm__toggle-off').hide();
            $('.template-bgm__toggle-on').show();
            for (var i = 0; i < listVideo.length; i++) {
                setMutiVideo(listVideo[i], volume, true);
            }
            setOffMute();
        }
        else {
            $('.template-bgm__toggle-off').show();
            $('.template-bgm__toggle-on').hide();
            for (var i = 0; i < listVideo.length; i++) {
                setMutiVideo(listVideo[i], volume, false)
            }
            setOnMute();
        }
    }

    function changeMutedVideo() {
        var listVideo = $('.list-video .video-item .video video');
        var volume = getValueVolume();
        for (var i = 0; i < listVideo.length; i++) {
            listVideo[i].volume = volume;
        }
    }

    function setVolumeVideoFull(el, status_mute) {
        if (status_mute) {
            $(el).attr('muted', 'muted');
            $(el).prop('muted', true);
        }
        else {
            $(el).removeAttr('muted');
            $(el).prop('muted', false);
        }
    }

    return {
        setValueVolumm: setValueVolumm,
        getValueVolume: getValueVolume,
        setOnMute: setOnMute,
        setOffMute: setOffMute,
        getStatusMute: getStatusMute,
        getStatusInput: getStatusInput,
        setMutiVideo: setMutiVideo,
        changeMutedTemplate: changeMutedTemplate,
        changeMutedVideo: changeMutedVideo,
        setVolumeVideoFull: setVolumeVideoFull,
        getVideoOption: getVideoOption
    }
})();

$(document).ready(function () {
});
