// ==UserScript==
// @name         Auto Skip YouTube Ads
// @version      1.3.0
// @description  Speed up and skip YouTube ads automatically
// @author       jso8910 and others
// @match        *://*.youtube.com/*
// ==/UserScript==

setInterval(() => {
    const video = document.querySelector('video');
    const skipButton = document.querySelector('.ytp-ad-skip-button, .ytp-ad-skip-button-modern, .ytp-skip-ad-button');
    
    // If ad is showing, speed it up
    if (video && document.querySelector('.ad-showing')) {
        video.playbackRate = 16; // Max speed
        video.muted = true; // Mute for good measure
        
        // Try to skip to end of ad
        if (video.duration) {
            video.currentTime = video.duration;
        }
    }
    
    // Click skip button whenever it appears
    if (skipButton) {
        skipButton.click();
    }
}, 100); // Check every 100ms for faster response
